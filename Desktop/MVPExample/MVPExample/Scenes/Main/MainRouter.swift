//
//  MainRouter.swift
//  MVPExample
//
//  Created by Anas Alhasani on 7/29/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

protocol MainRoutable {
    func showSummary(items: [String])
}

class MainRouter: MainRoutable {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showSummary(items: [String]) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController

        controller.configurator = SummaryConfigurator(items: items)
        
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
