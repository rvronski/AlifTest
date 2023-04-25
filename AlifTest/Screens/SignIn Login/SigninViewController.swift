//
//  ViewController.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

class SigninViewController: UIViewController {
    
    var viewModel: SigninViewModelProtocol
    
    init(viewModel: SigninViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var signView: SigninView = {
        let view = SigninView()
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        super.loadView()
        self.view = signView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupGesture()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else {
                return
            }
            switch state {
            case .initial:
               print("initial")
            case .succsess:
                DispatchQueue.main.async {
//                    self.viewModel.goToTabBar()
                    print("initial")
                }
            case .fail:
                    self.alertOk(title: "Что-то пошло не так", message: "Возможно такой пользователь уже зарегестрирован")
            case .userNotFound:
                fallthrough
            case .wrongPassword:
                self.alertOk(title: "Неверный пароль", message: nil)
            }
        }
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
}
extension SigninViewController: SigninViewDelegate {
    func signButtonDidTap(email: String, firstName: String, lastName: String) {
        viewModel.signInButtonDidTap(email: email, name: firstName, password: lastName)
    }
    
    func loginButtonDidTap() {
        
        viewModel.goToLogin()
    }
    
    func showAlert() {
        self.alertOk(title: "Заполните все поля регистрации", message: nil)

    }
    
    func showEmailAlert() {
        self.alertOk(title: "Неверный формат email", message: "Проверьте email адрес")
    }
}
