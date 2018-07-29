//
//  MainViewController.swift
//  MVPExample
//
//  Created by Anas Alhasani on 7/29/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: Outlet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var loginButton: UIButton!
    
    //MARK: Properties
    var configurator: MainConfigurable?
    var presenter: MainPresenterInput?
    
    //MARK: ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator = MainConfigurator()
        configurator?.configure(mainViewController: self)
        presenter?.viewDidLoad()
    }
    
}

//MARK: - Actions
private extension MainViewController {
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        presenter?.loginButtonTapped()
    }
}

//MARK: MainPresenterOutput
extension MainViewController: MainPresenterOutput {
    
    func displayTitleLabel(text: String) {
        titleLabel.text = text
    }
    
    func displayLoginButton(title: String) {
        loginButton.setTitle(title, for: .normal)
    }
    
    
}



















