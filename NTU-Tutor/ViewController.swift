//
//  ViewController.swift
//  NTU-Tutor
//
//  Created by Louis on 2016/12/30.
//  Copyright © 2016年 Louis's Mac. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var strId: String! = ""
    var strPw: String! = ""
    
    var PropertyListDictionary: NSMutableDictionary? = nil
    var viewContext: NSManagedObjectContext!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func onLoginBtnClicked(_ sender: Any) {
        showLoginDialog();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let strStringTablePath = Bundle.main.path(forResource: "AppStringTable", ofType: "plist")
        if let kPList = NSMutableDictionary(contentsOfFile: strStringTablePath!){
            PropertyListDictionary = kPList
        }
        viewContext = appDelegate.persistentContainer.viewContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "Segue_MainToAfterLogin" ){
            let vc = segue.destination as! LoginViewController
            vc.strId = self.strId;
            vc.strPw = self.strPw;
        }
    }
    
    func showLoginDialog(){
        if self.PropertyListDictionary != nil
        {
            let loginDialog = UIAlertController(title: self.PropertyListDictionary!["LoginDialogTitile"] as?    String, message: self.PropertyListDictionary!["LoginDialogMessage"] as? String, preferredStyle: .alert)
            loginDialog.addTextField{
                (textField) in textField.placeholder = self.PropertyListDictionary!["LoginDialogId"] as?    String
            }
            loginDialog.addTextField{
                (textField) in textField.placeholder = self.PropertyListDictionary!["LoginDialogPw"] as?    String
                textField.isSecureTextEntry = true
            }
            
            let loginAction = UIAlertAction(title: self.PropertyListDictionary!["LoginButtonLabel"] as?    String, style: .default ){
                (action)in
                self.strId = loginDialog.textFields![0].text
                self.strPw = loginDialog.textFields![1].text
                print( "uid = \(self.strId)")
                print( "pw = \(self.strPw)")
                self.onLogin()
            }
            let cancelAction = UIAlertAction(title: self.PropertyListDictionary!["CancelButtonLabel"] as?    String, style: .cancel ){
                (action)in
                self.dismiss(animated: true, completion: nil)
            }
            let createAccountAction = UIAlertAction(title: self.PropertyListDictionary!["CreateAccountButtonLabel"] as?    String, style: .default ){
                (action)in
                self.strId = loginDialog.textFields![0].text
                self.strPw = loginDialog.textFields![1].text
                print( "uid = \(self.strId)")
                print( "pw = \(self.strPw)")
                self.onCreateAccount()
            }

            loginDialog.addAction(loginAction)
            loginDialog.addAction(cancelAction)
            loginDialog.addAction(createAccountAction)
            
            show(loginDialog, sender: self)
            
        }
    }

    func onLogin() -> Void {
        //storyboard?.instantiateViewController(withIdentifier: "LoginSB")
        do {
            let allAccounts = try viewContext.fetch(TutorAccount.fetchRequest())
            for account in allAccounts as! [TutorAccount]
            {
                let strFetchId: String = account.id! as String
                let strFetchPw: String = account.password! as String
                if( strFetchId == strId && strFetchPw == strPw )
                {
                    self.performSegue(withIdentifier: "Segue_MainToAfterLogin", sender: self)
                    return
                }
            }
            showAlertDialog(title: "Login Fail", message: "Invalid account or password")
            return
            
        } catch {
            return
        }

    }
    
    func onCreateAccount() -> Void
    {
        do {
            let allAccounts = try viewContext.fetch(TutorAccount.fetchRequest())
            for account in allAccounts as! [TutorAccount]
            {
                if( account.id == strId ){
                    showAlertDialog(title: "Create Account Fail", message: "Account is already exist!")
                    return
                }
            }
        }catch{
        
        }
        
        var newAccount = NSEntityDescription.insertNewObject(forEntityName: "TutorAccount", into: viewContext) as! TutorAccount
        newAccount.id = strId
        newAccount.password = strPw
        appDelegate.saveContext()
    }
    
    func showAlertDialog( title: String, message: String ) -> Void{
        let alertDialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel ){
            (action)in
            self.dismiss(animated: true, completion: nil)
        }
        alertDialog.addAction( okAction )
        show(alertDialog, sender: self)
    }
}

