//
//  CreateAccountPage.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/1/10.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CreateAccountPage: UIViewController {

    @IBOutlet weak var TextEditEmail: UITextField!
    @IBOutlet weak var LabelEmailHint: UILabel!
    @IBOutlet weak var LabelPwHint: UILabel!
    @IBOutlet weak var ButtonCreateAccount: UIButton!
    @IBOutlet weak var TextEditPw: UITextField!
    @IBOutlet weak var TextEditPwAgain: UITextField!
    @IBOutlet weak var TextEditUserName: UITextField!
    @IBOutlet weak var MaleCheckBox: CustomCheckBox!
    @IBOutlet weak var FemaleCheckBox: CustomCheckBox!
    
    var sexList = [String]()
    
    @IBAction func onMaleCheckBoxClicked(_ sender: Any) {
        MaleCheckBox.isChecked = true
        FemaleCheckBox.isChecked = false
    }
    @IBAction func onFemaleCheckBoxClicked(_ sender: Any) {
        MaleCheckBox.isChecked = false
        FemaleCheckBox.isChecked = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sexList.append("男")
        sexList.append("女")
        LabelEmailHint.text = "Your E-mail will be used as login account"
        LabelPwHint.text = "Yout Password should be at least 8 characters"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnTouchDownCreateButton(_ sender: Any) {
        if let strEmail = TextEditEmail.text, let strPw = TextEditPw.text, let strPwAgain = TextEditPwAgain.text, let strUserName = TextEditUserName.text
        {
            let bEmailOk = !strEmail.isEmpty
            let bPwOk = !strPw.isEmpty && strPw.characters.count >= 8
            let bPwAgainSame = strPw == strPwAgain
            let bNameOk = !strUserName.isEmpty
            if ( !bEmailOk ){
                ShowErrorAlert(view: self, title: "Error", message: "請輸入 E-mail")
                return
            }
            else if( !bPwOk ){
                ShowErrorAlert(view: self, title: "Error", message: "密碼長度至少要8個字元")
                return
            }
            else if( !bPwAgainSame ){
                ShowErrorAlert(view: self, title: "Error", message: "兩次密碼輸入須一致")
                return
            }
            else if( !bNameOk ){
                ShowErrorAlert(view: self, title: "Error", message: "請輸入姓名")
                return
            }

            FIRAuth.auth()?.createUser(withEmail: strEmail, password: strPw)
            {
                (user, error) in
                if( error != nil ){
                    ShowErrorAlert( view: self, title: "Oops!", message: error!.localizedDescription)
                }
                else{
                    //self.ShowErrorAlert( title: "Successful", message: "Create Account Successful")
                    user?.sendEmailVerification(){
                        (error) in
                        if( error != nil ){
                            ShowErrorAlert( view: self, title: "Send E-mail for verification fail", message: error!.localizedDescription)
                            return
                        }
                    }
                    
                    // Send the user's info to the firebase database
                    if let currentUser = user{
                        FirebaseDatabaseRef.child("Users/\(currentUser.uid)/UserMail").setValue(strEmail)
                        FirebaseDatabaseRef.child("Users/\(currentUser.uid)/UserName").setValue(strUserName)
                        if( self.MaleCheckBox.isChecked ){
                            FirebaseDatabaseRef.child("Users/\(currentUser.uid)/Sex").setValue("男")
                        }
                        else if( self.FemaleCheckBox.isChecked ){
                            FirebaseDatabaseRef.child("Users/\(currentUser.uid)/Sex").setValue("女")
                        }
                        
                    }
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainPage")
                    if( vc != nil ){
                        self.present(vc!, animated: true, completion: nil)
                    }
                }
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}

