//
//  MainPresenter.swift
//  CoreDataExample
//
//  Created by Kacper Wygoda on 02.05.2018.
//  Copyright (c) 2018 Kacper Wygoda. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MainPresentationLogic {
    func presentFetchedTasks(response: Main.FetchData.Response.FetchTasks)
    func prepareToRoute(response: Main.PrepareToRoute.Response.RouteToAddTaskVC)
    func informAboutUpdatedPickedTask(response: Main.UpdateDataStorage.Response)
    func informAboutObjectsChanges(response: Main.UpdateDataStorage.Response)
    func informAboutChangingTaskDoneProperty(response: Main.UpdateDataStorage.Response)
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
    
    // MARK: Do something
    func informAboutChangingTaskDoneProperty(response: Main.UpdateDataStorage.Response) {
        let viewModel = Main.UpdateDataStorage.ViewModel()
        viewController?.updateStoredObjects(viewModel: viewModel)
    }
    
    func informAboutObjectsChanges(response: Main.UpdateDataStorage.Response) {
        let viewModel = Main.UpdateDataStorage.ViewModel()
        viewController?.updateStoredObjects(viewModel: viewModel)
    }
    
    func informAboutUpdatedPickedTask(response: Main.UpdateDataStorage.Response) {
        let viewModel = Main.UpdateDataStorage.ViewModel()
        viewController?.pickedTaskDidUpdate(viewModel: viewModel)
    }

    func prepareToRoute(response: Main.PrepareToRoute.Response.RouteToAddTaskVC) {
        let viewModel = Main.PrepareToRoute.ViewModel()
        viewController?.performRoute(viewModel: viewModel)
    }
    
    func presentFetchedTasks(response: Main.FetchData.Response.FetchTasks) {
        let viewModel = Main.FetchData.ViewModel.FetchTasks(tasks: response.tasks)
        viewController?.displayFetchedTasks(viewModel: viewModel)
    }
}