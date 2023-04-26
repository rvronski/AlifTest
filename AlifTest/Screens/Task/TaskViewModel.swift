//
//  TaskViewModel.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

protocol TaskViewModelProtocol: ViewModelProtocol {
    func getTaskArray(user: User) -> [Task]
    func createTask(deadline: Date, executor: String, taskName: String, user: User)
    func pushCreateTask(user: User)
    func isCompleted(taskName: String, completion: @escaping () -> Void)
    func cancelDone(taskName: String, completion: @escaping () -> Void)
    func deleteTask(task: Task)
    func changeTask(taskName: String, deadline: Date, executor: String, newTaskName: String)
    func goToEdit(task: Task)
    func getUser(email: String, completion: @escaping (User?) -> Void)
}

class TaskViewModel: TaskViewModelProtocol {
    
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    var coordinator: TaskCoordinator!
    
    func getTaskArray(user: User) -> [Task] {
        let array = coreDataManager.task(user: user)
        return array
    }
    
    func createTask(deadline: Date, executor: String, taskName: String, user: User) {
        self.coreDataManager.createTask(deadline: deadline, executor: executor, taskName: taskName, user: user)
    }
    
    func pushCreateTask(user: User) {
        coordinator.goTo(viewModel: self, pushTo: .createTask(self,user))
    }
    func goToEdit(task: Task) {
        coordinator.goTo(viewModel: self, pushTo: .edit(self, task))
    }
    func isCompleted(taskName: String, completion: @escaping () -> Void) {
        coreDataManager.isCompleted(taskName: taskName) {
            completion()
        }
    }
    func cancelDone(taskName: String, completion: @escaping () -> Void) {
        coreDataManager.cancelDone(taskName: taskName) {
            completion()
        }
    }
    func deleteTask(task: Task) {
        coreDataManager.deleteTask(task: task)
    }
    
    func changeTask(taskName: String, deadline: Date, executor: String, newTaskName: String) {
        coreDataManager.changeTask(taskName: taskName, deadline: deadline, executor: executor, newTaskName: newTaskName)
    }
    func getUser(email: String, completion: @escaping (User?) -> Void) {
        coreDataManager.getUser(email: email) { user in
            guard let user else {
                completion(nil)
                return }
            completion(user)
        }
    }
}
