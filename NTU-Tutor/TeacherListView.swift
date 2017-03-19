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
    @IBOutlet weak var SearchBar: UISearchBar!
    
    var AllTeacherData: NSArray?
    var TeacherDataPassTheFilter: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib( nibName: "UserTableViewCell", bundle:nil )
        TeacherTable.register( nib, forCellReuseIdentifier: "Cell" )
        
        FirebaseDatabaseRef.child("\(gs_strDatabaseTeacherRoot!)").observeSingleEvent(of: .value, with: {
            (snapshot) in
            // Get user value
            let allUserData = snapshot.value as? NSDictionary //[uid,data]
            self.AllTeacherData = allUserData?.allValues as NSArray?
            self.TeacherDataPassTheFilter = self.AllTeacherData
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
        if let data = TeacherDataPassTheFilter
        {
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserTableViewCell
        
        if( TeacherDataPassTheFilter != nil ){
            if let teacherData = TeacherDataPassTheFilter![ indexPath.row ] as? NSDictionary{
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

extension TeacherListView : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if (searchBar.text?.isEmpty)!
        {
            TeacherDataPassTheFilter = AllTeacherData
        }
        else{
            TeacherDataPassTheFilter = []
            if let allData = AllTeacherData{
                for data in allData
                {
                    if let dict = data as? NSDictionary
                    {
                        let strUserName = dict.value(forKey: "UserName") as! String
                        if strUserName.lowercased().contains(searchText.lowercased()){
                            TeacherDataPassTheFilter = TeacherDataPassTheFilter?.adding(dict) as NSArray?
                        }
                    }
                }
            }
        }
        self.TeacherTable.reloadData()
    }
}
