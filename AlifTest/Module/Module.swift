//
//  Module.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

protocol ViewModelProtocol: AnyObject {}

struct Module {
    
    enum ModuleType {
        case signIn
        case login
        case task
        case settings
       
    }
    
    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let view: UIViewController
}
extension Module.ModuleType {
    var tabBarItem: UITabBarItem {
        switch self {
        case .signIn:
            fallthrough
        case .login:
            fallthrough
        case .task:
            return UITabBarItem(title: nil,image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        case .settings:
            return UITabBarItem(title: nil,image: UIImage(systemName: "hammer"), tag: 1)
       
        }
    }
}

