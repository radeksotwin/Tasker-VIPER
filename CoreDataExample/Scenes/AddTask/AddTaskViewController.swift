//
//  AddTaskViewController.swift
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

protocol AddTaskDisplayLogic: class {
    func displayUpdatedDate(viewModel: AddTask.UpdateDataStroage.ViewModel.UpdateDate)
    func displayUpdatedTime(viewModel: AddTask.UpdateDataStroage.ViewModel.UpdateTime)
    func displayUpdatedColor(viewModel: AddTask.UpdateDataStroage.ViewModel.UpdateColor)
    func displayFetchedTaskComponents(viewModel: AddTask.FetchData.ViewModel)
    func fetchAlert(viewModel: AddTask.SaveTask.ViewModel)
    func dismissAfterSavingData(viewModel: AddTask.SaveTask.ViewModel)
    func displayFetchedAlert(viewModel: AddTask.FetchAlert.ViewModel)
}

class AddTaskViewController: UIViewController, AddTaskDisplayLogic, CDEViewController {
    
    var interactor: AddTaskBusinessLogic?
    var router: (NSObjectProtocol & AddTaskRoutingLogic & AddTaskDataPassing)?
    
    fileprivate var markedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
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
        setUpView()
        setDataSourceAndDelegate()
        setObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTaskComponents()

    }
    
    deinit {
        removeObservers()
        print("🔥🔥🔥AddTaskViewController🔥🔥🔥")
    }
    
    func setDataSourceAndDelegate() {
        subtitleTextView.delegate = self
        titleTextField.delegate = self
        scrollView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setUpView() {
    }
    
    func setObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(AddTaskViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddTaskViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.keyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.keyboardWillShow, object: nil)
    }
    
    @IBOutlet weak var subtitleTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var dateStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var timeStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        updateDate(date: sender.date)
    }
    
    @IBAction func resizeDateStackView(_ sender: UIButton) {
        let height = dateStackViewHeight.constant
        datePicker.isHidden = height == 100 ? false : true
        dateStackViewHeight.constant = height == 100 ? 200 : 100
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.view.layoutIfNeeded()
            }, completion: nil)
        print(datePicker.isHidden)
    }
    
    @IBAction func timePickerAction(_ sender: UIDatePicker) {
        updateTime(date: sender.date)
    }
    
    @IBAction func resizeTimeStackView(_ sender: UIButton) {
        let height = timeStackViewHeight.constant
        timePicker.isHidden = height == 100 ? false : true
        timeStackViewHeight.constant = height == 100 ? 200 : 100
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    
    @IBAction func addBarButton(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        saveTask()
    }
    
    @IBAction func titleTextDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        updateTitle(title: text)
    }
    
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }

    @objc func keyboardWillHide(_ sender: NSNotification) {
        dateStackViewHeight.constant = 100
        timeStackViewHeight.constant = 100
        timeLabel.isHidden = false
        dateLabel.isHidden = false
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    @objc func keyboardWillShow(_ sender: NSNotification) {
        dateStackViewHeight.constant = 0
        timeStackViewHeight.constant = 0
        timeLabel.isHidden = true
        dateLabel.isHidden = true
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func tapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.addTarget(self, action: #selector(endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func endEditing(_ tapGestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func fetchTaskComponents() {
        let request = AddTask.FetchData.Request()
        interactor?.fetchTaskComponents(request: request)
    }
    
    func saveTask() {
        let request = AddTask.SaveTask.Request()
        interactor?.saveTask(request: request)
    }
    func updateColor(colorIndex: Int) {
        let request = AddTask.UpdateDataStroage.Request.UpdateColor(colorIndex: colorIndex)
        interactor?.updateColor(request: request)
    }
    func updateDate(date: Date) {
        let request = AddTask.UpdateDataStroage.Request.UpdateDate(date: date)
        interactor?.updateDate(request: request)
    }
    
    func updateTime(date: Date) {
        let request = AddTask.UpdateDataStroage.Request.UpdateTime(time: date)
        interactor?.updateTime(request: request)
    }
    
    func updateTitle(title: String) {
        let request = AddTask.UpdateDataStroage.Request.UpdateTitle(title: title)
        interactor?.updateTitle(request: request)
    }
    
    func updateSubtitle(subtitle: String) {
        let request = AddTask.UpdateDataStroage.Request.UpdateSubtitle(subtitle: subtitle)
        interactor?.updateSubtitle(request: request)
    }
    
    func displayUpdatedDate(viewModel: AddTask.UpdateDataStroage.ViewModel.UpdateDate) {
        dateLabel.text = viewModel.date
    }
    
    func displayUpdatedTime(viewModel: AddTask.UpdateDataStroage.ViewModel.UpdateTime) {
        timeLabel.text = viewModel.time
    }
    
    func displayUpdatedColor(viewModel: AddTask.UpdateDataStroage.ViewModel.UpdateColor) {
        markedIndexPath = IndexPath(row: viewModel.colorIndex, section: 0)
        collectionView.reloadData()
        collectionView.scrollToItem(at: markedIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    func displayFetchedTaskComponents(viewModel: AddTask.FetchData.ViewModel) {
        let time = viewModel.task.time as Date
        let date = viewModel.task.date as Date
        
        timePicker.setDate(time, animated: true)
        datePicker.setDate(date, animated: true)
        dateLabel.text = Date.fullDateString(date: date)
        timeLabel.text = Date.convertDateToHourAndMinutes(date: time)
        titleTextField.text = viewModel.task.title
        subtitleTextView.text = viewModel.task.subtitle
        updateColor(colorIndex: Int(viewModel.task.colorIndex))
    }
    
    func fetchAlert(viewModel: AddTask.SaveTask.ViewModel) {
        let request = AddTask.FetchAlert.Request()
        interactor?.createAlert(request: request)
    }
    
    func displayFetchedAlert(viewModel: AddTask.FetchAlert.ViewModel) {
        present(viewModel.alert, animated: true, completion: nil)
    }
    
    func dismissAfterSavingData(viewModel: AddTask.SaveTask.ViewModel) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddTaskViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.id, for: indexPath) as! ColorCollectionViewCell
        cell.backgroundColor = Constants.colors[indexPath.row]
        cell.imageView.isHidden = indexPath == markedIndexPath ? false : true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateColor(colorIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height - 10
        return CGSize(width: height, height: height)
    }
}

extension AddTaskViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            view.endEditing(true)
        }
    }
}

extension AddTaskViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        updateSubtitle(subtitle: text)
    }
    
}

extension AddTaskViewController {
    
    private func setup() {
        let viewController = self
        let interactor = AddTaskInteractor()
        let presenter = AddTaskPresenter()
        let router = AddTaskRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}