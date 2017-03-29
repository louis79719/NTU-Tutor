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
    
    @IBOutlet weak var MaleCheckBox: CustomCheckBox!
    @IBOutlet weak var FemaleCheckBox: CustomCheckBox!
    @IBOutlet weak var NoSexLimitCheckBox: CustomCheckBox!
    
    
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
        
    }
    @IBAction func OnCancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
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
