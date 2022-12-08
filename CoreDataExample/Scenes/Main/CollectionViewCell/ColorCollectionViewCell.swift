//
//  ColorCollectionViewCell.swift
//  CoreDataExample
//
//  Created by Kacper Wygoda on 05.05.2018.
//  Copyright © 2018 Kacper Wygoda. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    static let id: String = "ColorCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView() {
        layer.cornerRadius = 14
        layer.masksToBounds = true
//        imageView.image = #imageLiteral(resourceName: "check-mark")
    }
}
