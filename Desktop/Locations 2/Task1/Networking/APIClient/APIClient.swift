//
//  APIClient.swift
//  Task1
//
//  Created by Nour Abukhaled on 7/26/18.
//  Copyright © 2018 Nour Abukhaled. All rights reserved.
//

import UIKit
import Alamofire

class APIClient {
    
    static func execute(request: APIRequest,
                 success: @escaping ([locations]) -> Void,
                 failure: @escaping (String) -> Void ) {
        
        Alamofire.request(request.baseUrl + request.methodName,
                          method: .post,
                          parameters: request.parameters,
                          encoding: JSONEncoding.default,
                          headers: request.headers).validate().responseJSON { (response) in
            
                            if response.result.isFailure {
                                
                                failure(response.result.error?.localizedDescription ?? "Sorry the service is currently not available, please try agian later")
                                
                            } else {
                                
                                let jsonDictionary = response.result.value as? [String: Any] ?? [:]
                                
                                let model = request.object(from: jsonDictionary)
                                
                                success(model)
                            }
        }
    }
}

