//
//  ViewController.swift
//  NTU-Tutor
//
//  Created by Louis on 2016/12/30.
//  Copyright © 2016年 Louis's Mac. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    var strEmail: String! = ""
    var strPw: String! = ""
    
    var PropertyListDictionary: NSMutableDictionary? = nil
    var viewContext: NSManagedObjectContext!
    var manageObjectModel: NSManagedObjectModel!
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
        manageObjectModel = appDelegate.persistentContainer.managedObjectModel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "Segue_MainToAfterLogin" ){
            let vc = segue.destination as! LoginViewController
            vc.strId = self.strEmail;
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
                self.strEmail = loginDialog.textFields![0].text
                self.strPw = loginDialog.textFields![1].text
                self.onLogin()
            }
            let cancelAction = UIAlertAction(title: self.PropertyListDictionary!["CancelButtonLabel"] as?    String, style: .cancel ){
                (action)in
                self.dismiss(animated: true, completion: nil)
            }
            let createAccountAction = UIAlertAction(title: self.PropertyListDictionary!["CreateAccountButtonLabel"] as?    String, style: .default ){
                (action)in
                self.strEmail = loginDialog.textFields![0].text
                self.strPw = loginDialog.textFields![1].text
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
        FIRAuth.auth()?.signIn(withEmail: strEmail, password: strPw ){
            (user, error) in
            if( error != nil ){
                ShowErrorAlert(view: self, title: "Oops!", message: error!.localizedDescription)
            }
            else{
                self.performSegue(withIdentifier: "Segue_MainToAfterLogin", sender: self)
            }
        }

    }
    
    func onCreateAccount() -> Void
    {
        if let loginPage = storyboard?.instantiateViewController(withIdentifier: "CreateAccountPage")
        {
                show(loginPage, sender: self)
        }
//        do {
//            let allAccounts = try viewContext.fetch(TutorAccount.fetchRequest())
//            for account in allAccounts as! [TutorAccount]
//            {
//                if( account.id == strId ){
//                    showAlertDialog(title: "Create Account Fail", message: "Account is already exist!")
//                    return
//                }
//            }
//        }catch{
//        
//        }
//        
//        var newAccount = NSEntityDescription.insertNewObject(forEntityName: "TutorAccount", into: viewContext) as! TutorAccount
//        newAccount.id = strId
//        newAccount.password = strPw
//        appDelegate.saveContext()
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
