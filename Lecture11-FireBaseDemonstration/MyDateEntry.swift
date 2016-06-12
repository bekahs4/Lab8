//
//  File.swift
//  Lecture11-FireBaseDemonstration
//
//  Created by Jonathan Engelsma on 6/7/16.
//  Copyright © 2016 Jonathan Engelsma. All rights reserved.
//

import Foundation
import Firebase


struct MyDateEntry {
    
    //let key: String!
    let name: String!
    let status: Bool
    
    
    init(name: String, status: Bool, key: String = "") {
        //self.key = key
        self.name = name
        self.status = status
    }
    
    
    init(snapshot: FIRDataSnapshot) {
//        let dateStringFormatter = NSDateFormatter()
//        dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZ"
//        dateStringFormatter.timeZone = NSTimeZone(name: "UTC")
        
        
        //key = snapshot.key
        name = snapshot.value!["name"] as! String
        let purchaseStatus = snapshot.value!["status"] as! Bool
        status = purchaseStatus
//        date = dateStringFormatter.dateFromString(dateStr)
    }
    
    
    init(snapshot: Dictionary<String,AnyObject>) {
//        let dateStringFormatter = NSDateFormatter()
//        dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZ"
//        dateStringFormatter.timeZone = NSTimeZone(name: "UTC")
        
        
        //key = snapshot.key
        name = snapshot["name"] as! String
//        let dateStr = snapshot["date"] as! String
        let purchaseStatus = snapshot["status"] as! Bool
//        date = dateStringFormatter.dateFromString(dateStr)
        status = purchaseStatus
    }
    
    
    func toAnyObject() -> AnyObject {
        return [
            "name": name,
            "status": status,
        ]
    }
    
    
}