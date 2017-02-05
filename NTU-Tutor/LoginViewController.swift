//
//  LoginViewController.swift
//  NTU-Tutor
//
//  Created by Louis on 2016/12/31.
//  Copyright © 2016年 Louis's Mac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var prevPageBtn: UIBarButtonItem!
    @IBOutlet weak var LoginWelcomeLabel: UILabel!
    
    @IBOutlet weak var GoToStudentListViewButton: UIButton!
    @IBOutlet weak var GoToTeacherListViewButton: UIButton!
    
    @IBAction func onPrevPageBtnClick(_ sender: Any) {
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
        var strText = "Hello " + strId + ", your passowrd is "
        if( !strPw.isEmpty)
        {
            for _ in 1...strPw.characters.count
            {
                strText += "*"
            }
        }
        LoginWelcomeLabel.text = strText
        LoginWelcomeLabel.lineBreakMode = .byWordWrapping
        LoginWelcomeLabel.numberOfLines = 0;
    }

}
