//
//  SettingsViewController.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var viewModel: SettingsViewModelProtocol
    
    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var outButton = CustomButton(buttonText: "Выйти", textColor: .white, background: .buttonColor, fontSize: 15, fontWeight: .regular)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        outButton.tapButton = { [weak self] in
            self?.alertOkCancel(title: "Выйти из профиля?", message: nil) {
                self?.viewModel.returnToLogin()
            }
        }
    }
    private func setupView() {
        self.view.addSubview(outButton)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
        
            outButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            outButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            outButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            outButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
