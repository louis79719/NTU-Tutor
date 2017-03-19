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

class LoginViewController: UIViewController {

    var strEmail: String! = ""
    var strPw: String! = ""
    var kUserDefaults : UserDefaults!
    
    var viewContext: NSManagedObjectContext!
    var manageObjectModel: NSManagedObjectModel!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func onLoginBtnClicked(_ sender: Any) {
        showLoginDialog();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FirebaseDatabaseRef = FIRDatabase.database().reference()
        viewContext = appDelegate.persistentContainer.viewContext
        manageObjectModel = appDelegate.persistentContainer.managedObjectModel
        
        kUserDefaults = UserDefaults.standard
        if let strAccount = kUserDefaults.value(forKey: gs_strUserDefaultAccount) as? String,
           let strPassword = kUserDefaults.value(forKey: gs_strUserDefaultPassword) as? String
        {
            self.strEmail = strAccount
            self.strPw = strPassword
            self.onLogin()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "Segue_LoginViewToAccountView" ){
            let vc = segue.destination as! AccountViewController
            vc.strId = self.strEmail;
            vc.strPw = self.strPw;
        }
    }
    
    func showLoginDialog(){
        let loginDialog = UIAlertController(
            title: PlistAttributeManager.GetAttribute(byVar: "LoginDialogTitile"),
            message: PlistAttributeManager.GetAttribute(byVar: "LoginDialogMessage"), preferredStyle: .alert)
        loginDialog.addTextField{
            (textField) in textField.placeholder = PlistAttributeManager.GetAttribute(byVar: "LoginDialogId")
        }
        loginDialog.addTextField{
            (textField) in textField.placeholder = PlistAttributeManager.GetAttribute(byVar: "LoginDialogPw")
            textField.isSecureTextEntry = true
        }
        
        let loginAction = UIAlertAction(title: PlistAttributeManager.GetAttribute(byVar: "LoginButtonLabel"), style: .default ){
            (action)in
            self.strEmail = loginDialog.textFields![0].text
            self.strPw = loginDialog.textFields![1].text
            self.onLogin()
        }
        let cancelAction = UIAlertAction(title: PlistAttributeManager.GetAttribute(byVar: "CancelButtonLabel"), style: .cancel ){
            (action)in
            self.dismiss(animated: true, completion: nil)
        }
        let createAccountAction = UIAlertAction(title: PlistAttributeManager.GetAttribute(byVar: "CreateAccountButtonLabel"), style: .default ){
            (action)in
            self.onCreateAccount()
        }
        
        loginDialog.addAction(loginAction)
        loginDialog.addAction(cancelAction)
        loginDialog.addAction(createAccountAction)
        
        show(loginDialog, sender: self)
    }

    func onLogin() -> Void {
        FIRAuth.auth()?.signIn(withEmail: strEmail, password: strPw ){
            (user, error) in
            if( error != nil ){
                ShowErrorAlert(view: self, title: "Oops!", message: error!.localizedDescription)
            }
//            else if( !((FIRAuth.auth()?.currentUser?.isEmailVerified)!) ){
//                ShowErrorAlert(view: self, title: "Oops!", message: "Your account haven't been verified through e-mail.")
//                do{
//                    try FIRAuth.auth()?.signOut()
//                }
//                catch let error as NSError {
//                    ShowErrorAlert(view: self, title: "Sign out error!", message: error.localizedDescription)
//                }
//            }
            else{
                self.kUserDefaults.set(self.strEmail, forKey: gs_strUserDefaultAccount)
                self.kUserDefaults.set(self.strPw, forKey: gs_strUserDefaultPassword)
                self.kUserDefaults.synchronize()
                self.performSegue(withIdentifier: "Segue_LoginViewToAccountView", sender: self)
            }
        }

    }
    
    func onCreateAccount() -> Void
    {
        if let createAccontPage = storyboard?.instantiateViewController(withIdentifier: "CreateAccountPage")
        {
            show(createAccontPage, sender: self)
        }
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
