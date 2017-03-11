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
    var nWaitCount : Int! = 0{
        didSet{
            if( nWaitCount == 0 && bAllDataSended ){
                dismiss(animated: true)
            }
        }
    }
    var bAllDataSended : Bool! = false
    
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var PasswordAgainText: UITextField!
    @IBOutlet weak var EditOkButton: UIButton!
    
    @IBOutlet weak var FemaleCheckBox: CustomCheckBox!
    @IBOutlet weak var MaleCheckBox: CustomCheckBox!
    @IBOutlet weak var NameText: UITextField!
    
    @IBOutlet weak var FavorSubjectText: UITextField!
    @IBOutlet weak var SchoolAndDepartmentText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = FIRAuth.auth()?.currentUser
        
        FirebaseDatabaseRef.child("Users").child((currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let userData = snapshot.value as? NSDictionary
            let userName = userData?["UserName"] as? String ?? ""
            self.NameText.text = userName
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func OnMaleChecked(_ sender: Any) {
        MaleCheckBox.isChecked = true
        FemaleCheckBox.isChecked = false
    }
    @IBAction func OnFemaleChecked(_ sender: Any) {
        MaleCheckBox.isChecked = false
        FemaleCheckBox.isChecked = true
    }
    
    @IBAction func OnEditOkButtonClicked(_ sender: Any) {
        if( !(PasswordText.text?.isEmpty)! ){
            if( PasswordText.text == PasswordAgainText.text ){
                currentUser?.updatePassword(PasswordText.text!){
                    (error) in
                    if( error != nil ){
                        ShowErrorAlert( view: self, title: "Update Password fail", message: error!.localizedDescription)
                    }
                }
            }
            else{
                ShowErrorAlert( view: self, title: "Fail", message: "Enter the same password twice.")
            }
        }
        
        if( !(NameText.text?.isEmpty)! ){
            if let userName = NameText.text{
                UpdateUserData(key: "UserName", value: userName)
            }
        }
        
        if( self.MaleCheckBox.isChecked ){
            UpdateUserData(key: "Sex", value: "男")
        }
        else if( self.FemaleCheckBox.isChecked ){
            UpdateUserData(key: "Sex", value: "女")
        }
        
        if !( FavorSubjectText.text?.isEmpty )!{
            UpdateUserData(key: "FavorSubject", value: FavorSubjectText.text!)
        }
        
        if !( SchoolAndDepartmentText.text?.isEmpty )!{
            UpdateUserData(key: "SchoolDepartment", value: SchoolAndDepartmentText.text!)
        }
        
        bAllDataSended = true
        if( nWaitCount == 0 ){
            self.dismiss(animated: true)
        }
    }

    @IBAction func OnCancelButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func UpdateUserData(key: String, value: String){
        nWaitCount = nWaitCount + 1
        if let userId = currentUser?.uid{
            FirebaseDatabaseRef.child("Users").child(userId).child(key).runTransactionBlock({ (dataIn) -> FIRTransactionResult in
                dataIn.value = value
                return FIRTransactionResult.success(withValue: dataIn)
            }) { (error, bCompletion, snap) in
                if( error != nil ){
                    ShowErrorAlert(view: self, title: "Update fail", message: (error?.localizedDescription)!)
                }
                if !bCompletion {
                    print("Couldn't Update the node")
                }
                self.nWaitCount = self.nWaitCount - 1
            }
        }
    }
    
}
