//
//  CashOutsJson.swift
//  Task1
//
//  Created by Nour Abukhaled on 4/11/18.
//  Copyright © 2018 Nour Abukhaled. All rights reserved.
//

import Foundation
import Alamofire

class JsonResponse {
    
    func getCashOutsJson (completionHandler: @escaping ([locations]) -> Void)  {
        
        var cashOutsArray: [locations] = []
        
        if cashOutsArray != [] {
            completionHandler(cashOutsArray)
        }
        
        let url: URL = URL(string: "https://sms.hbtf.com.jo/HBTFmbank/MobServiceWs.aspx?SrvID=wrListATM")!
        Alamofire.request(url,
                          method: .post,
                          parameters: [
                            "CustAttr":"T",
                            "DeviceType":"Postman",
                            "MAC":"02:00:00:00:00:00"
                           ],
                          encoding: JSONEncoding.default,
                          headers: ["User-Agent":"IOS"]
            ).validate().responseJSON { response in
    
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST in CashOuts Request")
                    print(response.result.error!)
                    return
                }
                guard let cashOutsResponseDectionary = response.result.value as? [String: Any] else {
                    print("didn't get JSON Response from API CashOuts Request")
                    print("Error: \(response.result.error ?? "Error" as! Error)")
                    return
                }

                guard let cashOutsJsonArray = cashOutsResponseDectionary["ATMS"] as? [[String: Any]] else {
                    print("didn't get ATMs from Json Response")
                    return
                }
                        
                     //   var cashOutsArray: [locations] = []
                        
                        for dictionary in cashOutsJsonArray {
                            let cashItem = locations()
                            cashItem.title = dictionary["EName"] as? String ?? ""
                            cashItem.desrp = dictionary["ELoc"] as? String ?? ""
                            cashItem.LocX =  dictionary["Latitude"] as? Double ?? 0.0
                            cashItem.LocY =  dictionary["Longitude"] as? Double ?? 0.0
                            cashItem.ID = dictionary["ATMID"] as? String ?? ""
                            cashOutsArray.append(cashItem)
                        }
                        
                        completionHandler(cashOutsArray)
                    }
           }
    
    func getBranchesJson (completionHandler: @escaping ([locations]) -> Void)  {
        
        var branchesArray: [locations] = []
        
        let url: URL = URL(string: "https://sms.hbtf.com.jo/HBTFmbank/MobServiceWs.aspx?SrvID=wrBankInfo")!
        Alamofire.request(url,
                          method: .post,
                          parameters: [
                            "CustAttr":"T",
                            "DeviceType":"Postman",
                            "MAC":"02:00:00:00:00:00"
                          ],
                          encoding: JSONEncoding.default,
                          headers: ["User-Agent":"IOS"]
            ).validate().responseJSON {  response in
               
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST in Branches Request")
                    print(response.result.error!)
                    return
                }
                guard let branchesResponseDectionary = response.result.value as? [String: Any] else {
                    print("didn't get JSON Response from API Branches Request")
                    print("Error: \(response.result.error ?? "Error" as! Error)")
                    return
                }
                
                guard let branchesJsonArray = branchesResponseDectionary["Branches"] as? [[String: Any]] else {
                    print("didn't get Branches from Json Response")
                    completionHandler(branchesArray)
                    return
                }

                        for dictionary in branchesJsonArray {
                            let branchItem = locations()
                            branchItem.title = dictionary["BranchEName"] as? String ?? ""
                            branchItem.desrp = dictionary["ELoc"] as? String ?? ""
                            branchItem.LocX = dictionary["Latitude"] as? Double ?? 0.0
                            branchItem.LocY = dictionary["Longitude"] as? Double ?? 0.0
                            branchItem.ID = dictionary["BranchID"] as? String ?? ""
                            branchesArray.append(branchItem)
                        }
                        completionHandler(branchesArray)
                    }
            }
}
