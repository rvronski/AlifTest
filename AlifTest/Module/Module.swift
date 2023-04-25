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
       
    }
    
    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let view: UIViewController
}


