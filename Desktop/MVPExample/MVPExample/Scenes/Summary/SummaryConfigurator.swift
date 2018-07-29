//
//  SummaryConfigurator.swift
//  MVPExample
//
//  Created by Anas Alhasani on 7/29/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

protocol SummaryConfigurable {
    func configure(summaryViewController: SummaryViewController)
}

class SummaryConfigurator: SummaryConfigurable {
    
    let items: [String]
    
    init(items: [String]) {
        self.items = items
    }
    
    func configure(summaryViewController: SummaryViewController) {
        
        let presenter = SummaryPresenter(output: summaryViewController, items: items)
        
        summaryViewController.presenter = presenter
    }
}
