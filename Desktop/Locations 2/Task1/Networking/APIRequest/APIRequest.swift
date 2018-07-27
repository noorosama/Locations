//
//  APIRequest.swift
//  Task1
//
//  Created by Nour Abukhaled on 7/26/18.
//  Copyright © 2018 Nour Abukhaled. All rights reserved.
//

import UIKit

protocol APIRequest {
    
    var methodName: String { get }
    
    var baseUrl: String { get }
    
    var parameters: [String: Any] { get }
    
    var headers: [String: String] { get }
    
    func object(from json: [String: Any]) -> [locations]
    
}

extension APIRequest {
    
    var baseUrl: String {
        
        return ""
        
    }
    
    var headers: [String: String] {
        
        return ["User-Agent":"IOS"]
    }
    
}
