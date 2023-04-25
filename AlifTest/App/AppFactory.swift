//
//  AppFactory.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

class AppFactory {
    
    
    private let coreDataManager: CoreDataManagerProtocol
   
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        case.signIn:
            let viewModel = SigninViewModel(coreDataManager: coreDataManager)
            let view = UINavigationController(rootViewController: SigninViewController(viewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        case .login:
            let viewModel = SigninViewModel(coreDataManager: coreDataManager)
            let view = LoginViewController(viewModel: viewModel)
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
//        case .task:
//            print("initial")
//            let viewModel = PageOneViewModel(networkManager: networkManager)
//            let view = UINavigationController(rootViewController: PageOneViewController(viewModel: viewModel))
//            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        
        }
    }
}
