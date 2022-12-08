//
//  Task+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Kacper Wygoda on 05.05.2018.
//  Copyright © 2018 Kacper Wygoda. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var time: NSDate
    @NSManaged public var date: NSDate
    @NSManaged public var colorIndex: Int16
    @NSManaged public var subtitle: String
    @NSManaged public var title: String
    @NSManaged public var taskDone: Bool
    
}
