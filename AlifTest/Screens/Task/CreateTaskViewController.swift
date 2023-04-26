//
//  CreateTaskViewController.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

class CreateTaskViewController: UIViewController {
    
    
    var viewModel: TaskViewModelProtocol
    
    init(viewModel: TaskViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var timeLabel = InfoLabels(inform: "Выполнить к", size: 17, weight: .regular, color: .black)
    private lazy var time = InfoLabels(inform: "ВРЕМЯ", size: 13, weight: .semibold, color: .black)
    private lazy var executorLabel = InfoLabels(inform: "ИСПОЛНИТЕЛЬ", size: 13, weight: .semibold, color: .black)
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.backgroundColor = .white
        datePicker.tintColor = .purple
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
        
    }()
    
    private lazy var executorTextField: UITextField = {
        let executorTextField = UITextField()
        executorTextField.translatesAutoresizingMaskIntoConstraints = false
        executorTextField.placeholder = "Исполнитель"
        executorTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return executorTextField
    }()
    
    private lazy var descriptionText: UITextField = {
        let descriptionText = UITextField()
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.placeholder = "Напишите задание"
        descriptionText.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        descriptionText.becomeFirstResponder()
//        descriptionText.text = " "
        return descriptionText
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Создать"
        let leftButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(popVC))
        let rightButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveHabit))
        leftButton.tintColor = .orange
        rightButton.tintColor = .orange
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(datePicker)
        self.view.addSubview(timeLabel)
        self.view.addSubview(descriptionText)
        self.view.addSubview(executorTextField)
        self.view.addSubview(time)
        self.view.addSubview(executorLabel)
        
        NSLayoutConstraint.activate([
            
            self.descriptionText.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 21),
            self.descriptionText.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            
            self.executorLabel.topAnchor.constraint(equalTo: self.descriptionText.bottomAnchor,constant: 15),
            self.executorLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 16),
            
            self.executorTextField.topAnchor.constraint(equalTo: self.executorLabel.bottomAnchor, constant: 7),
            self.executorTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            
            self.time.topAnchor.constraint(equalTo: self.executorTextField.bottomAnchor, constant: 15),
            self.time.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            
            self.timeLabel.topAnchor.constraint(equalTo: self.time.bottomAnchor, constant: 7),
            self.timeLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            
            
            self.datePicker.centerYAnchor.constraint(equalTo: self.timeLabel.centerYAnchor),
            self.datePicker.leftAnchor.constraint(equalTo: self.timeLabel.rightAnchor, constant: 10),
            
        ])
    }
    
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveHabit() {
        
        guard let taskName = descriptionText.text, !taskName.isEmpty else {
            self.alertOk(title: "Добавьте название для задачи", message: nil)
            return
        }
       
        let deadline = datePicker.date
        let executor = executorTextField.text ?? ""
        
        viewModel.createTask(deadline: deadline, executor: executor, taskName: taskName)
        popVC()
    }
    
}

