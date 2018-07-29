//
//  SummaryCell.swift
//  MVPExample
//
//  Created by Anas Alhasani on 7/29/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

protocol SummaryCellPresentable {
    func displayLabel(text: String)
}

class SummaryCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!

}

extension SummaryCell: SummaryCellPresentable {
    
    func displayLabel(text: String) {
        titleLabel.text = text
    }
    
    
}

