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
    
    @IBAction func onLoginBtnClicked(_ sender: Any) {
        showLoginDialog();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        let loginDialog = UIAlertController(title: "Login", message: "Login to NTU-Tutor", preferredStyle: .alert)
        loginDialog.addTextField{
            (textField) in textField.placeholder = "uid"
        }
        loginDialog.addTextField{
            (textField) in textField.placeholder = "pw"
                           textField.isSecureTextEntry = true
        }
        
        let loginAction = UIAlertAction(title: "Login", style: .default ){
            (action)in
            self.strId = loginDialog.textFields![0].text
            self.strPw = loginDialog.textFields![1].text
            print( "uid = \(self.strId)")
            print( "pw = \(self.strPw)")
            self.login( uid: self.strId, pw: self.strPw )
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel ){
            (action)in
            self.dismiss(animated: true, completion: nil)
        }
        loginDialog.addAction(loginAction)
        loginDialog.addAction(cancelAction)
        
        show(loginDialog, sender: self)
    }

    func login( uid: String!, pw: String! ) -> Void {
        //storyboard?.instantiateViewController(withIdentifier: "LoginSB")
        self.performSegue(withIdentifier: "Segue_MainToAfterLogin", sender: self)
    }
}

