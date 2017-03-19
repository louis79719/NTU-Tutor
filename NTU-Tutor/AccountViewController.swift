//
//  LoginViewController.swift
//  NTU-Tutor
//
//  Created by Louis on 2016/12/31.
//  Copyright © 2016年 Louis's Mac. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var logoutBtn: UIBarButtonItem!
    @IBOutlet weak var GoToEditAccountViewButton: UIButton!
    @IBOutlet weak var GoToStudentListViewButton: UIButton!
    @IBOutlet weak var GoToTeacherListViewButton: UIButton!
    
    @IBAction func onLogoutBtnClicked(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: gs_strUserDefaultAccount)
        UserDefaults.standard.removeObject(forKey: gs_strUserDefaultPassword)
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "SegueLoginToMain", sender: self)
    }
    
    
    var strId: String = "Nil"
    var strPw: String = "Nil"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUi();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UpdateUi(){
    }

}
