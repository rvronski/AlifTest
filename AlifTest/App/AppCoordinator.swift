//
//  AppCoordinator.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

final class AppCoordinator: Coordinatable {
    
    enum PushVC {
        case loginVC(ViewModelProtocol)
        case tabBar
    }
    
    private let coreDataManager: CoreDataManagerProtocol
    private(set) var coordinators: [Coordinatable] = []
    private(set) var module: Module?
    private let factory: AppFactory
    var navigationController: UINavigationController
    init(factory: AppFactory, navigationController: UINavigationController, coreDataManager: CoreDataManagerProtocol) {
        self.factory = factory
        self.navigationController = navigationController
        self.coreDataManager = coreDataManager
    }

    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: .signIn)
        let viewController = module.view
        (module.viewModel as! SigninViewModel).coordinator = self
        self.module = module
        return viewController
    }
    
    func goTo(viewModel: ViewModelProtocol, pushTo: PushVC) {
        switch pushTo {
        case let .loginVC(viewModel):
            let viewControllerToPush = LoginViewController(viewModel: viewModel as! SigninViewModelProtocol)
            (module!.view as? UINavigationController)?.pushViewController(viewControllerToPush, animated: true)
        case .tabBar:
            let taskCoordinator = TaskCoordinator(moduleType: .task, factory: factory, navigationController: UINavigationController())
            let settingsCoordinator = SettingsCoordinator(moduleType: .settings, factory: factory, navigationController: UINavigationController())
            let taskVC = taskCoordinator.start()
            let setVC = settingsCoordinator.start()
           
            let tabBarController = AppTabBarController(viewControllers: [taskVC, setVC])
            addCoordinator(coordinator: taskCoordinator)
            addCoordinator(coordinator: settingsCoordinator)
           
            (module!.view as? UINavigationController)?.pushViewController(tabBarController, animated: true)
        }
    }
   
    func addCoordinator(coordinator: Coordinatable) {
        guard coordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        coordinators.append(coordinator)
    }

    
    
    func removeCoordinator() {
        coordinators.removeAll()
    }
    
}


