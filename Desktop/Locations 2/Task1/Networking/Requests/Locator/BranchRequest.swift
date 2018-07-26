//
//  BranchRequest.swift
//  Task1
//
//  Created by Admin user on 7/26/18.
//  Copyright © 2018 Nour Abukhaled. All rights reserved.
//

import Foundation

struct BranchRequest: APIRequest {
    
    var methodName: String {
        
        return "wrBankInfo"
    }
    
    var parameters: [String : Any] {
        
        return [
                 "CustAttr":"T",
                 "DeviceType":"Postman",
                 "MAC":"02:00:00:00:00:00"
               ]
    }
    
    func object(from json: [String : Any]) -> [locations] {
        
        
        var branchesArray: [locations] = []
        
        let branchesJSONArray = json["Branches"] as? [[String: Any]] ?? []
        
        for dictionary in branchesJSONArray {
            
            let branchItem = locations()
            
            branchItem.title = dictionary["BranchEName"] as? String ?? ""
            branchItem.desrp = dictionary["ELoc"] as? String ?? ""
            branchItem.LocX = dictionary["Latitude"] as? Double ?? 0.0
            branchItem.LocY = dictionary["Longitude"] as? Double ?? 0.0
            branchItem.ID = dictionary["BranchID"] as? String ?? ""
            
            branchesArray.append(branchItem)
            
            
        }
        
           return branchesArray
    }
    
}
