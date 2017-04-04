//
//  CreateAccountPage.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/1/10.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var TextEditEmail: UITextField!
    @IBOutlet weak var LabelEmailHint: UILabel!
    @IBOutlet weak var LabelPwHint: UILabel!
    @IBOutlet weak var ButtonCreateAccount: UIButton!
    @IBOutlet weak var TextEditPw: UITextField!
    @IBOutlet weak var TextEditPwAgain: UITextField!
    @IBOutlet weak var TextEditUserName: UITextField!
    @IBOutlet weak var MaleCheckBox: CustomCheckBox!
    @IBOutlet weak var FemaleCheckBox: CustomCheckBox!
    @IBOutlet weak var TeacherCheckBox: CustomCheckBox!
    @IBOutlet weak var StudentCheckBox: CustomCheckBox!
    
    @IBAction func onMaleCheckBoxClicked(_ sender: Any) {
        MaleCheckBox.isChecked = true
        FemaleCheckBox.isChecked = false
    }
    @IBAction func onFemaleCheckBoxClicked(_ sender: Any) {
        MaleCheckBox.isChecked = false
        FemaleCheckBox.isChecked = true
    }
    @IBAction func onTeacherCheckBoxClicked(_ sender: Any) {
        TeacherCheckBox.isChecked = true
        StudentCheckBox.isChecked = false
    }
    @IBAction func onStudentCheckBoxClicked(_ sender: Any) {
        TeacherCheckBox.isChecked = false
        StudentCheckBox.isChecked = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapOnViewRecognizer = UITapGestureRecognizer( target:self,
                                                          action:#selector(CreateAccountViewController.onMainViewTap(_:)))
        tapOnViewRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapOnViewRecognizer)
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

            FirebaseManager.GetAuth()?.createUser(withEmail: strEmail, password: strPw)
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
                    if let currentUser = user
                    {
                        let databaseRootName: String = self.TeacherCheckBox.isChecked ?
                            gs_strDatabaseTeacherRoot : gs_strDatabaseStudentRoot
   
                        FirebaseManager.GetDatabase()?.child("\(databaseRootName)/\(currentUser.uid)/\(gs_strDatabaseDataMail)").setValue(strEmail)
                        FirebaseManager.GetDatabase()?.child("\(databaseRootName)/\(currentUser.uid)/\(gs_strDatabaseDataName)").setValue(strUserName)
                        if( self.MaleCheckBox.isChecked ){
                            FirebaseManager.GetDatabase()?.child("\(databaseRootName)/\(currentUser.uid)/\(gs_strDatabaseDataSex)").setValue("男")
                        }
                        else if( self.FemaleCheckBox.isChecked ){
                            FirebaseManager.GetDatabase()?.child("\(databaseRootName)/\(currentUser.uid)/\(gs_strDatabaseDataSex)").setValue("女")
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
    
    func onMainViewTap(_:UITapGestureRecognizer){
        self.view.endEditing(true)
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

extension CreateAccountViewController : UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        self.view.endEditing(true)
    }
}

