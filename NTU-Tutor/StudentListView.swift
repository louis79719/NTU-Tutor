//
//  StudentListView.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/1/31.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import UIKit
import Firebase

class StudentListView: UITableViewController {

    @IBOutlet var StudentTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib( nibName: "UserTableViewCell", bundle:nil )
        StudentTable.register( nib, forCellReuseIdentifier: "Cell" )
    }

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.UserNameLabel.text = "Student 0"
            cell.UserSexLabel.text = "男"
            break
        case 1:
            cell.UserNameLabel.text = "Student 1"
            cell.UserSexLabel.text = "女"
            break
        case 2:
            cell.UserNameLabel.text = "Student 2"
            cell.UserSexLabel.text = "男"
            break
        default:
            break
        }
        
        return cell
    }
}
