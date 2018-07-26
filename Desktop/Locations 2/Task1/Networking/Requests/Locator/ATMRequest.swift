//
//  ATMRequest.swift
//  Task1
//
//  Created by Nour Abukhaled on 7/26/18.
//  Copyright © 2018 Nour Abukhaled. All rights reserved.
//

import UIKit

struct ATMRequest: APIRequest {
    
    var methodName: String {
        
        return "wrListATM"
    }
    
    var parameters: [String : Any] {
        
        return  [
                    "CustAttr": "T",
                    "DeviceType": "Postman",
                    "MAC": "02:00:00:00:00:00",
                ]
    }
    
    func object(from json: [String : Any]) -> [locations] {
        
        var ATMSArray: [locations] = []
        
        let ATMsJSONArray = json["ATMS"] as? [[String: Any]] ?? []
        
        for dictionary in ATMsJSONArray {
            
            let ATMItem = locations()
            
            ATMItem.title = dictionary["EName"] as? String ?? ""
            ATMItem.desrp = dictionary["ELoc"] as? String ?? ""
            ATMItem.LocX = dictionary["Latitude"] as? Double ?? 0.0
            ATMItem.LocY = dictionary["Longitude"] as? Double ?? 0.0
            ATMItem.ID = dictionary["ATMID"] as? String ?? ""
            
            ATMSArray.append(ATMItem)
            
        }
        
        return ATMSArray
    }
    
}


