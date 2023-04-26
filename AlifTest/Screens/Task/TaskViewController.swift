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
        self.taskArray = viewModel.getTaskArray()
        print(UIColor.white.description)
    }
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Задачи"
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentHabitVC))
        button.tintColor = .blue
        navigationItem.rightBarButtonItem = button

    }
 
    @objc func presentHabitVC() {
        print("button did push")
    }

}
extension TaskViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource { //HabitsCollectionViewCellDelegate {
   
  
//   func tapCircle(cell: HabitsCollectionViewCell) {
//       let vc = HabitViewController()
//       let collection = self.habitsCollectionView
//       guard let index = collection.indexPath(for:cell )?.row else {return}
//       let hab = HabitsStore.shared.habits[index]
//       if hab.isAlreadyTakenToday == false {
//           HabitsStore.shared.track(hab)
//           self.habitsCollectionView.reloadData()
////            vc.restartApplication()
//       
//       }
////        self.habitsCollectionView.reloadData()
//   }
   
   func numberOfSections(in collectionView: UICollectionView) -> Int {
       1
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//       if section == 0 {
//          return 1
//       }  else if section > 0 {
//      return HabitsStore.shared.habits.count
//       }
       return taskArray.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//       if indexPath.section == 0 {
//           let cell0 = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCell", for: indexPath) as! ProgressCollectionViewCell
//               return cell0
//       }
//       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitsCell", for: indexPath) as? HabitsCollectionViewCell else {
//           let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "DefoultCell", for: indexPath)
//           return cell
//       }
//       cell.setup(with: HabitsStore.shared.habits[indexPath.row])
//       cell.delegate = self
//       if HabitsStore.shared.habits[indexPath.row].isAlreadyTakenToday == false {
//           cell.circleImage.image = UIImage(systemName: "circle")
//       } else {
//           cell.circleImage.image = UIImage(systemName: "checkmark.circle.fill")}
//
//       return cell
       
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.indentifire, for: indexPath) as! TaskCollectionViewCell
       cell.setup(with: taskArray[indexPath.row])
       
       return cell
   }
       
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       if indexPath.section == 0 {
           let width = collectionView.frame.width - 33
           let height = width * 0.17492711
           return CGSize(width: width, height: height)
       }
       let itemWidth = collectionView.frame.width - 33
       let itemHeight = itemWidth * 0.37900875
       
       return CGSize(width: itemWidth, height: itemHeight)
   }
   
//   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//       if indexPath.section != 0 {
//           let controller = HabitDetailsViewController(habit: HabitsStore.shared.habits[indexPath.item])
//           controller.navigationItem.title = HabitsStore.shared.habits[indexPath.item].name
//           self.navigationController?.pushViewController(controller, animated: true)
//       }
//
   }
