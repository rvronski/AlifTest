//
//  TaskViewController.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

class TaskViewController: UIViewController {
    
    var viewModel: TaskViewModelProtocol
    var taskArray = [Task]()
    init(viewModel: TaskViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var taskView: TaskView = {
        let view = TaskView()
        return view
    }()
    
    override func loadView() {
        super.loadView()
        self.view = taskView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        taskView.configureCollectionView(dataSource: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.taskArray = viewModel.getTaskArray()
        taskView.taskCollectionView.reloadData()
    }
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Задачи"
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushCreateVC))
        button.tintColor = .buttonColor
        navigationItem.rightBarButtonItem = button

    }
 
    @objc func pushCreateVC() {
        viewModel.pushCreateTask()
    }

}
extension TaskViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
  
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return taskArray.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.indentifire, for: indexPath) as! TaskCollectionViewCell
       cell.setup(with: taskArray[indexPath.row])
       cell.delegate = self
       if taskArray[indexPath.row].isCompleted {
           cell.circleImage.image = UIImage(systemName: "checkmark.circle.fill")
           cell.isCompleted = true
       } else {
           cell.circleImage.image = UIImage(systemName: "circle")
           cell.isCompleted = false
       }
       return cell
   }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

       let itemWidth = collectionView.frame.width - 33
       let itemHeight = itemWidth * 0.37900875
       
       return CGSize(width: itemWidth, height: itemHeight)
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       collectionView.deselectItem(at: indexPath, animated: true)
       let task = taskArray[indexPath.row]
       viewModel.goToEdit(task: task)
       }
   }

extension TaskViewController: TaskCollectionCellDelegate {
    
    func cancelDone(taskName: String) {
        self.alertOkCancel(title: "Отменить выполнение?", message: nil) { [weak self] in
            self?.viewModel.cancelDone(taskName: taskName) {
                DispatchQueue.main.async {
                    self?.taskArray = (self?.viewModel.getTaskArray())!
                    self?.taskView.taskCollectionView.reloadData()
                }
            }
        }
    }
    
    func isCompleted(taskName: String) {
        viewModel.isCompleted(taskName: taskName) { [weak self] in
            DispatchQueue.main.async {
                self?.taskArray = (self?.viewModel.getTaskArray())!
                self?.taskView.taskCollectionView.reloadData()
            }
        }
    }
    
    
}
