//
//  TaskViewModel.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

protocol TaskViewModelProtocol: ViewModelProtocol {
    func getTaskArray() -> [Task]
    func createTask(deadline: Date, executor: String, taskName: String)
    func pushCreateTask()
    func isCompleted(taskName: String, completion: @escaping () -> Void)
    func cancelDone(taskName: String, completion: @escaping () -> Void)
    func deleteTask(task: Task)
    func changeTask(taskName: String, deadline: Date, executor: String, newTaskName: String)
    func goToEdit(task: Task)
    
}

class TaskViewModel: TaskViewModelProtocol {
    
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    var coordinator: TaskCoordinator!
    func getTaskArray() -> [Task] {
        let array = coreDataManager.task()
        return array
    }
    
    func createTask(deadline: Date, executor: String, taskName: String) {
        self.coreDataManager.createTask(deadline: deadline, executor: executor, taskName: taskName)
    }
    
    func pushCreateTask() {
        coordinator.goTo(viewModel: self, pushTo: .createTask(self))
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
    
}
