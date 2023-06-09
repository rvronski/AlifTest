//
//  SigninViewModel.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

protocol SigninViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((SigninViewModel.State) -> Void)? { get set }
    func goToTabBar()
    func goToLogin()
    func signInButtonDidTap(email: String, name: String, password: String)
    func loginButtonDidTap(email: String, password: String)
}

class SigninViewModel: SigninViewModelProtocol {
    
    enum State {
        case initial
        case succsess
        case userNotFound
        case wrongPassword
        case fail
    }
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    var coordinator: AppCoordinator!
    
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func signInButtonDidTap(email: String, name: String, password: String) {
        coreDataManager.createUser(email: email, name: name, password: password) { [weak self] result in
            DispatchQueue.main.async {
                if result {
                    self?.goToTabBar()
                } else {
                    self?.state = .fail
                }
            }
        }
    }
    
    func loginButtonDidTap(email: String, password: String) {
        coreDataManager.getUser(email: email) { [weak self] user in
            guard let user else { self?.state = .userNotFound
                return
            }
            DispatchQueue.main.async {
                if user.password == password {
                    UserDefaults.standard.set(email, forKey: "email")
                    self?.goToTabBar()
                } else {
                    self?.state = .wrongPassword
                }
            }
        }
    }
    
    func goToTabBar(){
        coordinator.goTo(viewModel: self, pushTo: .tabBar)
    }
    
    func goToLogin() {
        coordinator.goTo(viewModel: self, pushTo: .loginVC(self))
    }
    
}

