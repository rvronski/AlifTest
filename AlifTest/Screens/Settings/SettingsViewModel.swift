//
//  SettingsViewModel.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import Foundation

protocol SettingsViewModelProtocol: ViewModelProtocol {
    func returnToLogin()
}

class SettingsViewModel: SettingsViewModelProtocol {
    
    var coordinator: SettingsCoordinator!
    
    func returnToLogin() {
        coordinator.popToLogin()
    }
}
