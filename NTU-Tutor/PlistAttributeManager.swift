//
//  PlistAttributeManager.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/3/13.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//

import Foundation

class PlistAttributeManager
{
    static func GetAttribute( byVar: String ) -> String?
    {
        if PlistAttributeManager.PropertyListDictionary == nil
        {
            let strStringTablePath = Bundle.main.path(forResource: "AppStringTable", ofType: "plist")
            if let kPList = NSMutableDictionary(contentsOfFile: strStringTablePath!){
                PlistAttributeManager.PropertyListDictionary = kPList
            }
        }
        return PlistAttributeManager.PropertyListDictionary![byVar] as? String
    }
    
    static var PropertyListDictionary: NSMutableDictionary? = nil
}
