//
//  Utilities.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/1/15.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import Foundation
import Firebase
import UIKit

enum EAccountType: Int
{
    case Teacher
    case Student
    case Invalid
}

func ShowErrorAlert( view: UIViewController, title: String, message: String) {
    // Called upon signup error to let the user know signup didn't work.
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    view.present(alert, animated: true, completion: nil)
}


func CheckAccountType( uid: String!, afterCheck: @escaping (_ result: EAccountType)->Void ) -> Void
{
    FirebaseDatabaseRef.child(gs_strDatabaseTeacherRoot).child(uid).observeSingleEvent(of: .value, with: {
        (snapshot) in
        if (snapshot.value as? NSDictionary) != nil
        {
            afterCheck( EAccountType.Teacher )
        }
    })
    FirebaseDatabaseRef.child(gs_strDatabaseStudentRoot).child(uid).observeSingleEvent(of: .value, with: {
        (snapshot) in
        if (snapshot.value as? NSDictionary) != nil
        {
            afterCheck( EAccountType.Student )
        }
    })
    
    return
}
