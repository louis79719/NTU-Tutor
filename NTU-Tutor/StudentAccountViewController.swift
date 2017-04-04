//
//  StudentAccountViewController.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/3/26.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import UIKit

class StudentAccountViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnLogoutButtonClicked(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: gs_strUserDefaultAccount)
        UserDefaults.standard.removeObject(forKey: gs_strUserDefaultPassword)
        UserDefaults.standard.synchronize()
        self.dismiss(animated: true)
    }

    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
