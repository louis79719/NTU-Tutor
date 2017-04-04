//
//  RemoteDatabaseManager.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/4/4.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

enum EAccountType: Int
{
    case Teacher
    case Student
    case Invalid
}

class FirebaseManager
{
    static func Initialize()
    {
        FirebaseDatabaseRef = FIRDatabase.database().reference()
    }
    
    static func GetUser() -> FIRUser?
    {
        return FIRAuth.auth()?.currentUser
    }
    
    static func GetAuth() -> FIRAuth?
    {
        return FIRAuth.auth()
    }
    
    static func GetDatabase() -> FIRDatabaseReference?
    {
        return FirebaseDatabaseRef
    }
    
    static func SetValue(Key: String, Value: String)
    {
        FirebaseDatabaseRef?.child(Key).setValue(Value)
    }
    
    static func Login( strEmail: String, strPassword: String, onComplete: @escaping (FIRUser?, Error?)->Void )
    {
        FIRAuth.auth()?.signIn(withEmail: strEmail, password: strPassword, completion: onComplete)
    }
    
    static func CheckAccountType( afterCheck: @escaping (_ result: EAccountType)->Void ) -> Void
    {
        if let uid = GetUser()?.uid
        {
            FirebaseDatabaseRef?.child(gs_strDatabaseTeacherRoot).child(uid).observeSingleEvent(of: .value, with: {
                (snapshot) in
                if (snapshot.value as? NSDictionary) != nil
                {
                    afterCheck( EAccountType.Teacher )
                }
            })
            FirebaseDatabaseRef?.child(gs_strDatabaseStudentRoot).child(uid).observeSingleEvent(of: .value, with: {
                (snapshot) in
                if (snapshot.value as? NSDictionary) != nil
                {
                    afterCheck( EAccountType.Student )
                }
            })
        }
        return
    }
    
    
    static private var FirebaseDatabaseRef: FIRDatabaseReference? = nil
}
