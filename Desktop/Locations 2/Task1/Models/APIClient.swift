//
//  APIClient.swift
//  Task1
//
//  Created by Nour Abukhaled on 7/25/18.
//  Copyright © 2018 Nour Abukhaled. All rights reserved.
//

import UIKit
import Alamofire

/*
class APIClient: APIRequest {
  
    var methodName: String = "post"
    
    var baseUrl: URL = URL(string: "https://sms.hbtf.com.jo/HBTFmbank/MobServiceWs.aspx?SrvID=")!
    
    var parameters: [String : Any] = ["CustAttr":"T",
                                      "DeviceType":"Postman",
                                      "MAC":"02:00:00:00:00:00"
                                     ]
    var headers: [String : Any] = ["User-Agent":"IOS"]
    
    func object(from Json: [String : Any]) -> [locations] {
        
        Alamofire.request(baseUrl,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers).validate().response { response in
                            
                            <#code#>
        }
    }
    
    
}
*/

class APIClient {
    
    static func execute(request: APIRequest,
                 success: @escaping ([locations]) -> Void,
                 failure: @escaping (String) -> Void)  {
        
        Alamofire
            .request(request.baseUrl + request.methodName,
                     method: .post,
                     parameters: request.parameters,
                     encoding: JSONEncoding.default,
                     headers: request.headers)
            .validate()
            .responseJSON { (response) in
                
                if response.result.isFailure {
                    failure(response.result.error?.localizedDescription ?? "Sorry the service is currently not available, please try agian later")
                } else {
                    
                    let jsonDictionary = response.result.value as? [String: Any] ?? [:]
                    let locations = request.object(from: jsonDictionary)
                    success(locations)
                }
                
        }
        
    }
}

