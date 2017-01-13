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
    
    @IBAction func onPrevPageBtnClick(_ sender: Any) {
        self.performSegue(withIdentifier: "SegueLoginToMain", sender: self)
    }
    
    
    var strId: String = "Nil"
    var strPw: String = "Nil"
    var sexList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUi();
        //LoginWelcomeLabel.text = strWelcome
        // Do any additional setup after loading the view.
        sexList.append("男")
        sexList.append("女")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
