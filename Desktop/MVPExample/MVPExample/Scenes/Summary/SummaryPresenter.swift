//
//  SummaryPresenter.swift
//  MVPExample
//
//  Created by Anas Alhasani on 7/29/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

protocol SummaryPresenterInput {
    func viewDidLoad()
    func numberOfRows() -> Int
    func configure(cell: SummaryCellPresentable, at indexPath: IndexPath)
}

protocol SummaryPresenterOutput: class {
    func displayScreen(title: String)
}


class SummaryPresenter: SummaryPresenterInput {
    weak var output: SummaryPresenterOutput?
    let items: [String]
    
    init(output: SummaryPresenterOutput,
         items: [String]) {
        self.output = output
        self.items = items
    }
    
    func viewDidLoad() {
        output?.displayScreen(title: "Summary")
    }
    
    func numberOfRows() -> Int {
        return items.count
    }
    
    func configure(cell: SummaryCellPresentable, at indexPath: IndexPath) {
        let item = items[indexPath.row]
        cell.displayLabel(text: item)
        
    }
}












