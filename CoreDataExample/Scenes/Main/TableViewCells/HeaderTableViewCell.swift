//
//  HeaderTableViewCell.swift
//  CoreDataExample
//
//  Created by Kacper Wygoda on 02.05.2018.
//  Copyright © 2018 Kacper Wygoda. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    static let identifier: String = "HeaderCell"

    @IBOutlet weak var titleLabel: UILabel!
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
}
