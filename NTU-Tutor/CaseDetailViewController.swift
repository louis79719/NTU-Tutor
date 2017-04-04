//
//  CaseDetailViewController.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/4/3.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import UIKit

class CaseDetailViewController: UIViewController {

    @IBOutlet weak var SubjectText: UITextField!
    @IBOutlet weak var StudentGradeText: UITextField!
    @IBOutlet weak var MaleCheckBox: CustomCheckBox!
    @IBOutlet weak var FemaleCheckBox: CustomCheckBox!
    @IBOutlet weak var AllSexCheckBox: CustomCheckBox!
    @IBOutlet weak var PaymentText: UITextField!
    @IBOutlet weak var PhoneNumberText: UITextField!
    
    var m_strCaseOwnerUid: String = ""
    var m_strSubject: String = ""
    var m_strGrade: String = ""
    var m_strTeacherSex: String = ""
    var m_strPayment: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SubjectText.text = m_strSubject
        StudentGradeText.text = m_strGrade
        if( m_strTeacherSex == "男" )
        {
            MaleCheckBox.isChecked = true
            FemaleCheckBox.isChecked = false
            AllSexCheckBox.isChecked = false
        }
        else if( m_strTeacherSex == "女" )
        {
            MaleCheckBox.isChecked = false
            FemaleCheckBox.isChecked = true
            AllSexCheckBox.isChecked = false
        }
        else
        {
            MaleCheckBox.isChecked = false
            FemaleCheckBox.isChecked = false
            AllSexCheckBox.isChecked = true
        }
        PaymentText.text = m_strPayment
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func onConfirmTutorCase(){
        PhoneNumberText.isHidden = false
        FirebaseManager.GetDatabase()?.child(gs_strDatabaseStudentRoot).child(m_strCaseOwnerUid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let userData = snapshot.value as? NSDictionary
            {
                let StudentPhoneNumber = userData[ gs_strDatabaseDataPhone ] as? String ?? "Invalid Phone Number"
                self.PhoneNumberText.text = StudentPhoneNumber
            }
        })
    }

    
    @IBAction func CaseConfirmButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "應徵確認", message: "確定要應徵這個家教？", preferredStyle: UIAlertControllerStyle.actionSheet)
        let actionOk = UIAlertAction(title: "確定", style: .default){
            (action) in
            self.onConfirmTutorCase()
        }
        let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
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
