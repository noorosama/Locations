//
//  LocatorRequest.swift
//  Task1
//
//  Created by Admin user on 7/25/18.
//  Copyright © 2018 Nour Abukhaled. All rights reserved.
//

import Foundation

//struct LoginRequest: APIRequest {
//    let username: String
//    let password: String
//
//    var methodName: String { return "asgsahg"}
//
//    var parameters: [String : Any] {
//        return [
//            "CustID": username,
//            "password": password
//        ]
//    }
//
//    func object(from Json: [String : Any]) -> [locations] {
//        return []
//    }
//
//
//}
struct ATMRequest: APIRequest {
    
    let latitude: Double
    let longtude: Double
    
    var methodName: String {
        return "wrListATM"
    }
    
    var parameters: [String : Any] {
        return [
            "CustAttr": "T",
            "DeviceType": "Postman",
            "MAC": "02:00:00:00:00:00",
//            "X": latitude,
//            "Y": longtude
        ]
    }
    
    func object(from Json: [String : Any]) -> [locations] {
        
        var atmsArray: [locations] = []
        
        let branchesJSONArray = Json["Branches"] as? [[String: Any]] ?? []
        
        for dictionary in branchesJSONArray {
            let branchItem = locations()
            branchItem.title = dictionary["BranchEName"] as? String ?? ""
            branchItem.desrp = dictionary["ELoc"] as? String ?? ""
            branchItem.LocX = dictionary["Latitude"] as? Double ?? 0.0
            branchItem.LocY = dictionary["Longitude"] as? Double ?? 0.0
            branchItem.ID = dictionary["BranchID"] as? String ?? ""
            atmsArray.append(branchItem)
        }
        
        return atmsArray
    }
    

}
