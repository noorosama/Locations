//
//  SummaryViewController.swift
//  MVPExample
//
//  Created by Anas Alhasani on 7/29/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: properties
    var presenter: SummaryPresenterInput!
    var configurator: SummaryConfigurable?
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(summaryViewController: self)
        presenter?.viewDidLoad()
    }
}

//MARK: - UITableViewDataSoruce
extension SummaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as! SummaryCell
        cell.selectionStyle = .none
        presenter.configure(cell: cell, at: indexPath)
        return cell
    }
}

//MARK: - SummaryPresenterOutput
extension SummaryViewController: SummaryPresenterOutput {
    
    func displayScreen(title: String) {
        self.title = title
    }
    
}

