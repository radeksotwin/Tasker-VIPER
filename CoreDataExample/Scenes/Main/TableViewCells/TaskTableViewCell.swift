//
//  TaskTableViewCell.swift
//  CoreDataExample
//
//  Created by Kacper Wygoda on 02.05.2018.
//  Copyright © 2018 Kacper Wygoda. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    static let identifier: String = "TaskCell"
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var task: Task! {
        didSet {
            setUpView()
        }
    }

    func setUpView() {
        guard task != nil else { return }
        let date = task.date as Date
        let time = task.time as Date
        colorView.backgroundColor = Constants.colors[Int(task.colorIndex)]
        
        timeLabel.text = Date.convertDateToHourAndMinutes(date: time)
        dateLabel.text = Date.converDateToShortString(date: date)
        
        if task.taskDone == true {
            let attributeTitle: NSMutableAttributedString =  NSMutableAttributedString(string: task.title)
            attributeTitle.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeTitle.length))

            let attributeSubtitle: NSMutableAttributedString =  NSMutableAttributedString(string: task.subtitle)
            attributeSubtitle.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeSubtitle.length))
            
            titleLabel.attributedText = attributeTitle
            subtitleLabel.attributedText = attributeSubtitle
        } else {
            let attributeTitle: NSMutableAttributedString =  NSMutableAttributedString(string: task.title)
            attributeTitle.addAttribute(.strikethroughStyle, value: 0, range: NSMakeRange(0, attributeTitle.length))
            
            let attributeSubtitle: NSMutableAttributedString =  NSMutableAttributedString(string: task.subtitle)
            attributeSubtitle.addAttribute(.strikethroughStyle, value: 0, range: NSMakeRange(0, attributeSubtitle.length))
            
            titleLabel.attributedText = attributeTitle
            subtitleLabel.attributedText = attributeSubtitle
        }
    }
}
