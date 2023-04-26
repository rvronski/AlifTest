//
//  SettingsCoordinator.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

class SettingsCoordinator: ModuleCoordinatable {
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
        let module = factory.makeModule(ofType: .settings)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        return viewController
    }
}
