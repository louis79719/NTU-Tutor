//
//  TeacherAccountViewController.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/3/26.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import UIKit

class TeacherAccountViewController: UIViewController
{

    
    @IBOutlet weak var EditAccountButton: UIButton!
    @IBOutlet weak var StudentCaseTableView: UITableView!
    
    var AllTutorCaseData: Array< NSDictionary > = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StudentCaseTableView.register(UITableViewCell.self, forCellReuseIdentifier: "StudentCaseCell")
        
        FirebaseDatabaseRef.child(gs_strDatabaseTutorCaseRoot).observeSingleEvent(of: .value, with: {
            (snapshot) in
            // Get user value
            let data = snapshot.value as? NSDictionary //[uid,caseDatas]
            let AllKeys = data?.allKeys as? [String]
            for key in AllKeys!{
                let keyValue = data?.value(forKey: key) as! NSDictionary
                for singleValue in keyValue.allValues{
                    self.AllTutorCaseData.append(singleValue as! NSDictionary)
                }
            }
            self.StudentCaseTableView.reloadData()
        }){ (error) in
            print(error.localizedDescription)
        }
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TeacherAccountViewController: UITableViewDataSource, UITableViewDelegate
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return AllTutorCaseData.count
    }
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCaseCell", for: indexPath)
        if indexPath.row < AllTutorCaseData.count
        {
            let caseData = AllTutorCaseData[ indexPath.row ]
            let strSubject = caseData.value(forKey: gs_strDatabaseCaseSubject) as! String?
            cell.textLabel?.text = strSubject
        }
        return cell
    }
}
