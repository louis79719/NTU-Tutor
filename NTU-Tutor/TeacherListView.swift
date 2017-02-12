//
//  TeacherListView.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/2/1.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import UIKit
import Firebase

class TeacherListView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Toolbar: UIToolbar!
    @IBOutlet weak var TeacherTable: UITableView!
    
    var AllTeacherData: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib( nibName: "UserTableViewCell", bundle:nil )
        TeacherTable.register( nib, forCellReuseIdentifier: "Cell" )
        
        FirebaseDatabaseRef.child("Users/").observeSingleEvent(of: .value, with: {
            (snapshot) in
            // Get user value
            let allUserData = snapshot.value as? NSDictionary //[uid,data]
            self.AllTeacherData = allUserData?.allValues as NSArray?
            self.TeacherTable.reloadData()
        }){ (error) in
            print(error.localizedDescription)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //let userID = FIRAuth.auth()?.currentUser?.uid
        // need to implement from Firbase database
        if( AllTeacherData != nil ){
            return AllTeacherData!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserTableViewCell
        
        if( AllTeacherData != nil ){
            if let teacherData = AllTeacherData![ indexPath.row ] as? NSDictionary{
                cell.UserNameLabel.text = teacherData.value(forKey: "UserName") as! String?
                cell.UserSexLabel.text = teacherData.value(forKey: "Sex") as! String?
            }
        }
        
        return cell
    }
    
    @IBAction func OnBackButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }


}
