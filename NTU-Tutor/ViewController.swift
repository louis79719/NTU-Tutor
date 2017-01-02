//
//  ViewController.swift
//  NTU-Tutor
//
//  Created by Louis on 2016/12/30.
//  Copyright © 2016年 Louis's Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var strId: String! = ""
    var strPw: String! = ""
    
    var PropertyListDictionary: NSMutableDictionary? = nil
    
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
            
            let loginAction = UIAlertAction(title: "Login", style: .default ){
                (action)in
                self.strId = loginDialog.textFields![0].text
                self.strPw = loginDialog.textFields![1].text
                print( "uid = \(self.strId)")
                print( "pw = \(self.strPw)")
                self.onLogin()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel ){
                (action)in
                self.dismiss(animated: true, completion: nil)
            }
            loginDialog.addAction(loginAction)
            loginDialog.addAction(cancelAction)
            
            show(loginDialog, sender: self)
            
        }
    }

    func onLogin() -> Void {
        //storyboard?.instantiateViewController(withIdentifier: "LoginSB")
        self.performSegue(withIdentifier: "Segue_MainToAfterLogin", sender: self)
    }
}

