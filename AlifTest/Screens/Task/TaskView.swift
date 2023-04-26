//
//  TaskView.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

class TaskView: UIView {
    
    lazy var collectionLayout: UICollectionViewFlowLayout = {
       let collectionLayout = UICollectionViewFlowLayout()
       collectionLayout.scrollDirection = .vertical
       collectionLayout.minimumLineSpacing = 12
       collectionLayout.minimumInteritemSpacing = 12
       collectionLayout.sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 17)
       return collectionLayout
   }()
   
    lazy var taskCollectionView: UICollectionView = {
       let taskCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionLayout)
        taskCollectionView.backgroundColor = .systemGray6
        taskCollectionView.translatesAutoresizingMaskIntoConstraints = false
       return taskCollectionView
   }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //   override func viewDidLoad() {
//       super.viewDidLoad()
//       self.setupNavigationBar()
//       self.setupView()
//       self.tabBarController?.tabBar.isHidden = false
//   }

   
   private func setupView() {
       self.addSubview(taskCollectionView)
       self.backgroundColor = .systemBackground
       
       
       NSLayoutConstraint.activate([
           self.taskCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
           self.taskCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
           self.taskCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
           self.taskCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor)
       ])
   }
   
    func configureCollectionView(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegateFlowLayout) {
        taskCollectionView.dataSource = dataSource
        taskCollectionView.delegate = delegate
        taskCollectionView.register(TaskCollectionViewCell.self, forCellWithReuseIdentifier: TaskCollectionViewCell.indentifire )
    }
    
//   @objc func presentHabitVC() {
//       let vc = HabitViewController()
//      let navController =  UINavigationController(rootViewController: vc)
//       navController.modalPresentationStyle = .fullScreen
//       self.navigationController?.present(navController, animated: true, completion: nil)
//
//
//
//   }
   
}


