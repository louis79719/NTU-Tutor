//
//  CreateAccountPage.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/1/10.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import UIKit

class CreateAccountPage: UIViewController {

    @IBOutlet weak var sexPickerView: UIPickerView!

    var sexList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sexList.append("男")
        sexList.append("女")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension CreateAccountPage : UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        if( pickerView == sexPickerView ){
            return 1
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if( pickerView == sexPickerView ){
            return sexList.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if( pickerView == sexPickerView ){
            return sexList[row]
        }
        return "Nil"
    }
}

