//
//  Utilities.swift
//  UrbanEaterDriver
//
//  Created by Nagaraju on 01/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import Foundation

class Utilities: NSObject {
    
    
    func trimString(string : String) -> String
    {
        let trimmedString = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString;
    }
    
    func ReplaceNullWithString(string : AnyObject) -> String
    {
        if string is NSNull
        {
            return ""
        }
        else if (String(describing: type(of: string)) != "__NSCFString")
        {
            return String(describing: string)
        }
        else
        {
            return string as! String
        }
    }
    
    func AdvanceCheckingNullValue(string : AnyObject) -> String
    {
        print("advance checking : ", String(describing: type(of: string)))
        
        if string is NSNull
        {
            return ""
        }
        else if (String(describing: type(of: string)) != "__NSCFString")
        {
            return String(describing: string)
        }
        else
        {
            return (string as? String)!
        }
    }
    
    func ReplaceNullWithArray(list : AnyObject) -> Array<Any>
    {
        if list is NSNull
        {
            return Array()
        }
        else
        {
            print("list here : ", list)
            
            return list as! Array
        }
    }
    func isValidEmail(testStr:String) -> Bool
    {
        print("validate emailId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
}
