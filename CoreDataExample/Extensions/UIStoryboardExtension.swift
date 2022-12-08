//
//  UIStoryboardExtension.swift
//  CoreDataExample
//
//  Created by Kacper Wygoda on 02.05.2018.
//  Copyright © 2018 Kacper Wygoda. All rights reserved.
//

import UIKit


extension UIStoryboard {
    static func addNC() -> AddTaskNavigationController {
        let addNC = UIStoryboard(name: "AddTask", bundle: nil).instantiateViewController(withIdentifier: AddTaskNavigationController.identifier) as! AddTaskNavigationController
        return addNC
    }
    
    static func addVC() -> AddTaskViewController {
        let addNC = UIStoryboard(name: "AddTask", bundle: nil).instantiateViewController(withIdentifier: AddTaskNavigationController.identifier) as! AddTaskNavigationController
        let addVC = addNC.childViewControllers[0] as! AddTaskViewController
        return addVC
    }
}
