//
//  MainConfigurator.swift
//  MVPExample
//
//  Created by Anas Alhasani on 7/29/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

protocol MainConfigurable {
    func configure(mainViewController: MainViewController)
}

class MainConfigurator: MainConfigurable {
    
    func configure(mainViewController: MainViewController) {
        
        let router = MainRouter(viewController: mainViewController)
        
        let presenter = MainPresenter(output: mainViewController, router: router)
        
        mainViewController.presenter = presenter
    }
    
    
}
