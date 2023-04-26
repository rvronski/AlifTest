//
//  TaskViewModel.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

protocol TaskViewModelProtocol: ViewModelProtocol {
   func getTaskArray() -> [Task]
}

class TaskViewModel: TaskViewModelProtocol {
    
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func getTaskArray() -> [Task] {
        let array = coreDataManager.task()
        return array
    }
}
