//
//  PostCaseViewController.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/3/27.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import UIKit

class PostCaseViewController: UIViewController {

    var subjectList: [String] = ["國文","數學","英文","物理化學","電腦","音樂","歷史地理"
    ,"其他"]
    
    @IBOutlet weak var SubjectTextEdit: UITextField!
    @IBOutlet weak var StudentGradeTextEdit: UITextField!
    @IBOutlet weak var MaleCheckBox: CustomCheckBox!
    @IBOutlet weak var FemaleCheckBox: CustomCheckBox!
    @IBOutlet weak var NoSexLimitCheckBox: CustomCheckBox!
    @IBOutlet weak var PaymentTextEdit: UITextField!
    @IBOutlet weak var LocationTextEdit: UITextField!
    @IBOutlet weak var OtherNoteTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapOnViewRecognizer = UITapGestureRecognizer( target:self,
                                                          action:#selector(PostCaseViewController.onMainViewTap(_:)))
        tapOnViewRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapOnViewRecognizer)
    }
    
    func onMainViewTap(_:UITapGestureRecognizer){
        self.view.endEditing(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnMaleClicked(_ sender: Any) {
        MaleCheckBox.isChecked = true
        FemaleCheckBox.isChecked = false
        NoSexLimitCheckBox.isChecked = false
    }
    @IBAction func OnFemaleClicked(_ sender: Any) {
        MaleCheckBox.isChecked = false
        FemaleCheckBox.isChecked = true
        NoSexLimitCheckBox.isChecked = false
    }
    @IBAction func OnNoSexLimitClicked(_ sender: Any) {
        MaleCheckBox.isChecked = false
        FemaleCheckBox.isChecked = false
        NoSexLimitCheckBox.isChecked = true
    }
    
    @IBAction func OnOkButtonClicked(_ sender: Any) {
        if let strUid: String = FirebaseManager.GetAuth()?.currentUser?.uid
        {
            let NewCaseReference = FirebaseManager.GetDatabase()?.child("\(gs_strDatabaseTutorCaseRoot)").child(strUid).childByAutoId()
            NewCaseReference?.child(gs_strDatabaseCaseSubject).setValue(SubjectTextEdit.text)
            NewCaseReference?.child(gs_strDatabaseCaseStudentGrade).setValue(StudentGradeTextEdit.text)
            if( MaleCheckBox.isChecked){
                NewCaseReference?.child(gs_strDatabaseCaseTeacherSex).setValue("男")
            }
            else if(FemaleCheckBox.isChecked){
                NewCaseReference?.child(gs_strDatabaseCaseTeacherSex).setValue("女")
            }
            else if(NoSexLimitCheckBox.isChecked){
                NewCaseReference?.child(gs_strDatabaseCaseTeacherSex).setValue("不限")
            }
            NewCaseReference?.child(gs_strDatabaseCaseHourPayment).setValue(PaymentTextEdit.text)
            NewCaseReference?.child(gs_strDatabaseCaseLocation).setValue(LocationTextEdit.text)
            NewCaseReference?.child(gs_strDatabaseCaseNote).setValue(OtherNoteTextView.text)
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func OnCancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func UpdateTutorCaseData(key: String, value: String){

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

//extension PostCaseViewController: UIPickerViewDataSource, UIPickerViewDelegate
//{
//    
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int
//    {
//        return 1
//    }
//    
//    
//    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
//    {
//        return self.subjectList.count
//    }
//    
//    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
//    {
//        if( component == 0 && row < self.subjectList.count ){
//            return self.subjectList[row]
//        }
//        return "None"
//    }
//}
