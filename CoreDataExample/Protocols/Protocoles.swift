//
//  Protocoles.swift
//  CoreDataExample
//
//  Created by Kacper Wygoda on 02.05.2018.
//  Copyright © 2018 Kacper Wygoda. All rights reserved.
//

import Foundation

protocol CDEViewController {
    func setDataSourceAndDelegate()
    func setObservers()
    func removeObservers()
}
