//
//  MainViewController.swift
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

protocol MainDisplayLogic: class {
    func displayFetchedTasks(viewModel: Main.FetchData.ViewModel.FetchTasks)
    func performRoute(viewModel: Main.PrepareToRoute.ViewModel)
    func pickedTaskDidUpdate(viewModel: Main.UpdateDataStorage.ViewModel)
    func updateStoredObjects(viewModel: Main.UpdateDataStorage.ViewModel)
}

class MainViewController: UIViewController, MainDisplayLogic, CDEViewController {
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    
    fileprivate var sections: [String] = ["Past", "Today", "Tomorrow", "Upcoming 7 days"]
    var tasks: Main.Tasks!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataSourceAndDelegate()
        setObservers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTasks()
        print("View appeared")
    }
    
    deinit {
        removeObservers()
        print("🔥🔥🔥MainViewController🔥🔥🔥")
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func setDataSourceAndDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setObservers() {
    }
    
    func removeObservers() {
    }
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        prepareToRoute(state: .new)
    }
    
    func prepareToRoute(state: Main.State) {
        let request = Main.PrepareToRoute.Request.RouteToAddTaskVC(state: state)
        interactor?.prepareToRoute(request: request)
    }
    
    func pickTaskToEdit(task: Task) {
        let request = Main.UpdateDataStorage.Request.UpdatePickedTask(pickedTask: task)
        interactor?.updatePickedTask(request: request)
    }
    
    func markAsDone() {
        let request = Main.UpdateDataStorage.Request()
        interactor?.markTaskAsDone(request: request)
    }
    
    func deleteObject() {
        let request = Main.UpdateDataStorage.Request()
        interactor?.deleteTask(request: request)
    }
    
    func performRoute(viewModel: Main.PrepareToRoute.ViewModel) {
        router?.routeTo(vc: AddTaskViewController())
    }
    
    func fetchTasks() {
        let request = Main.FetchData.Request()
        interactor?.fetchTasks(request: request)
    }
    
    func pickedTaskDidUpdate(viewModel: Main.UpdateDataStorage.ViewModel) {
        print("picked task has been updated")
    }
    
    func displayFetchedTasks(viewModel: Main.FetchData.ViewModel.FetchTasks) {
        tasks = viewModel.tasks
        tableView.reloadData()
    }
    
    func updateStoredObjects(viewModel: Main.UpdateDataStorage.ViewModel) {
        fetchTasks()
    }
  
}


extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        cell.title = sections[section]
        
        return cell.contentView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return tasks.past.count
        case 1:
            return tasks.today.count
        case 2:
            return tasks.tomorrow.count
        case 3:
            return tasks.upcoming7Days.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        switch indexPath.section {
        case 0:
            cell.task = tasks.past[indexPath.row]
        case 1:
            cell.task = tasks.today[indexPath.row]
        case 2:
            cell.task = tasks.tomorrow[indexPath.row]
        case 3:
            cell.task = tasks.upcoming7Days[indexPath.row]
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        switch indexPath.section {
        case 0:
            pickTaskToEdit(task: tasks.past[indexPath.row])
        case 1:
            pickTaskToEdit(task: tasks.today[indexPath.row])
        case 2:
            pickTaskToEdit(task: tasks.tomorrow[indexPath.row])
        case 3:
            pickTaskToEdit(task: tasks.upcoming7Days[indexPath.row])
        default:
            break
        }
        
        let deleteAction = UITableViewRowAction(style: .default, title: Constants.DELETE) { [weak self] (action, indexPath) in
            guard let me = self else { return }
            me.deleteObject()
        }
        
        let editAction = UITableViewRowAction(style: .default, title: Constants.EDIT) { [weak self] (action, indexPath) in
            guard let me = self else { return }
            me.prepareToRoute(state: .editing)
            
        }
        
        let doneAction = UITableViewRowAction(style: .default, title: Constants.DONE) { [weak self] (action, indexPath) in
            guard let me = self else { return }
            me.markAsDone()
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.9228059649, green: 0, blue: 0, alpha: 1)
        editAction.backgroundColor = #colorLiteral(red: 0.3918466866, green: 0.7212054133, blue: 0.1978799403, alpha: 1)
        doneAction.backgroundColor = #colorLiteral(red: 0.2405773699, green: 0.7062084079, blue: 1, alpha: 1)
        
        return [doneAction, editAction, deleteAction]
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}

extension MainViewController {
    
    private func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}