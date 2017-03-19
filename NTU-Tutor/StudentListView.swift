//
//  StudentListView.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/1/31.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import UIKit
import Firebase

class StudentListView: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var Toolbar: UIToolbar!
    @IBOutlet weak var StudentTable: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    
    var AllStudentData: NSArray?
    var StudentDataPassTheFilter: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib( nibName: "UserTableViewCell", bundle:nil )
        StudentTable.register( nib, forCellReuseIdentifier: "Cell" )
        FirebaseDatabaseRef.child("\(gs_strDatabaseStudentRoot)").observeSingleEvent(of: .value, with: {
            (snapshot) in
            // Get user value
            let allUserData = snapshot.value as? NSDictionary //[uid,data]
            self.AllStudentData = allUserData?.allValues as NSArray?
            self.StudentDataPassTheFilter = self.AllStudentData
            self.StudentTable.reloadData()
        }){ (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let data = StudentDataPassTheFilter
        {
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserTableViewCell
        if( StudentDataPassTheFilter != nil ){
            if let teacherData = StudentDataPassTheFilter![ indexPath.row ] as? NSDictionary{
                cell.UserNameLabel.text = teacherData.value(forKey: gs_strDatabaseDataName) as! String?
                cell.UserSexLabel.text = teacherData.value(forKey: gs_strDatabaseDataSex) as! String?
            }
        }
        
        return cell
    }
    
    @IBAction func OnBackButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }

}

extension StudentListView : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if (searchBar.text?.isEmpty)!
        {
            StudentDataPassTheFilter = AllStudentData
        }
        else{
            StudentDataPassTheFilter = []
            if let allData = AllStudentData{
                for data in allData
                {
                    if let dict = data as? NSDictionary
                    {
                        let strUserName = dict.value(forKey: gs_strDatabaseDataName) as! String
                        if strUserName.lowercased().contains(searchText.lowercased()){
                            StudentDataPassTheFilter = StudentDataPassTheFilter?.adding(dict) as NSArray?
                        }
                    }
                }
            }
        }
        self.StudentTable.reloadData()
    }
}
