//
//  TaskCoordinator.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

class TaskCoordinator: ModuleCoordinatable {
    
    enum Push {
        case createTask(ViewModelProtocol, User)
        case edit(ViewModelProtocol, Task)
    }
    
    var module: Module?
    private let factory: AppFactory
    private(set) var moduleType: Module.ModuleType
    private(set) var coordinators: [Coordinatable] = []
    private var navigationController: UINavigationController
    
    init(moduleType: Module.ModuleType, factory: AppFactory, navigationController: UINavigationController) {
        self.moduleType = moduleType
        self.factory = factory
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: .task)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        (module.viewModel as? TaskViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func goTo(viewModel: ViewModelProtocol, pushTo: Push) {
        switch pushTo {
        case let .createTask(viewModel, user):
            let viewControllerToPush = CreateTaskViewController(viewModel: viewModel as! TaskViewModelProtocol, user: user)
            (module!.view as? UINavigationController)?.pushViewController(viewControllerToPush, animated: true)
            
        case let .edit(viewModel, task):
             let viewControllerToPush = EditViewController(viewModel: viewModel as! TaskViewModelProtocol, task: task)
            (module!.view as? UINavigationController)?.pushViewController(viewControllerToPush, animated: true)
            
        }
    }
    
}
