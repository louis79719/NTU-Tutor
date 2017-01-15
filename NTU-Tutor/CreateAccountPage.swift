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
    @IBOutlet weak var PickerViewSex: UIPickerView!
    
    var sexList = [String]()
    
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
        if let strEmail = TextEditEmail.text, let strPw = TextEditPw.text, let strPwAgain = TextEditPwAgain.text
        {
            let bEmailOk = !strEmail.isEmpty
            let bPwOk = !strPw.isEmpty && strPw.characters.count >= 8
            let bPwAgainSame = strPw == strPwAgain
            if ( !bEmailOk ){
                self.ShowErrorAlert(title: "Error", message: "Invalid E-mail address")
                return
            }
            else if( !bPwOk ){
                self.ShowErrorAlert(title: "Error", message: "Invalid Password")
                return
            }
            else if( !bPwAgainSame ){
                self.ShowErrorAlert(title: "Error", message: "Please enter the same password in password again")
                return
            }

            FIRAuth.auth()?.createUser(withEmail: strEmail, password: strPw)
            {
                (user, error) in
                if( error != nil ){
                    self.ShowErrorAlert( title: "Oops!", message: error!.localizedDescription)
                }
                else{
                    print( "You have successfully create the account." )
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

    func ShowErrorAlert(title: String, message: String) {
        // Called upon signup error to let the user know signup didn't work.
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    
}

extension CreateAccountPage : UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        if( pickerView == PickerViewSex ){
            return 1
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if( pickerView == PickerViewSex ){
            return sexList.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if( pickerView == PickerViewSex ){
            return sexList[row]
        }
        return ""
    }
}

