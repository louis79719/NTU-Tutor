//
//  EditAccountViewController.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/2/5.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import UIKit
import Firebase

class EditAccountViewController: UIViewController {

    var currentUser : FIRUser? = nil
    
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var PasswordAgainText: UITextField!
    @IBOutlet weak var EditOkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = FIRAuth.auth()?.currentUser
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func OnEditOkButtonClicked(_ sender: Any) {
        if( PasswordText.text == PasswordAgainText.text ){
            currentUser?.updatePassword(PasswordText.text!){
                (error) in
                if( error != nil ){
                    ShowErrorAlert( view: self, title: "Update Password fail", message: error!.localizedDescription)
                }
                else{
                    self.dismiss(animated: true)
                }
            }
        }
        else{
            ShowErrorAlert( view: self, title: "Fail", message: "Enter the same password twice.")
        }
    }

    @IBAction func OnCancelButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}
