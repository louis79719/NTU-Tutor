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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
