//
//  TeacherListView.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/2/1.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import UIKit

class TeacherListView: UITableViewController {
    
    @IBOutlet var TeacherTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib( nibName: "UserTableViewCell", bundle:nil )
        TeacherTable.register( nib, forCellReuseIdentifier: "Cell" )
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //let userID = FIRAuth.auth()?.currentUser?.uid
        // need to implement from Firbase database
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.UserNameLabel.text = "Teacher 0"
            cell.UserSexLabel.text = "男"
            break
        case 1:
            cell.UserNameLabel.text = "Teacher 1"
            cell.UserSexLabel.text = "女"
            break
        case 2:
            cell.UserNameLabel.text = "Teacher 2"
            cell.UserSexLabel.text = "男"
            break
        default:
            break
        }
        
        return cell
    }

}
