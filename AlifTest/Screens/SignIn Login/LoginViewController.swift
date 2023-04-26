//
//  LoginViewController.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: SigninViewModelProtocol
    
    init(viewModel: SigninViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var welcomeLabel = InfoLabels(inform: "Welcome back", size: 30, weight: .bold, color: .black)
    
    private lazy var emailTextField = regTextField(placeholderText: "Email", typeKeyBoard: .emailAddress, isSecureText: false)
    
    private lazy var passwordTextField = UIShowHideTextField()
    
    private lazy var regButton = CustomButton(buttonText: "Login", textColor: .white, background: .buttonColor, fontSize: 20, fontWeight: .bold)
    
    private lazy var signInButton = CustomButton(buttonText: "Sign in", textColor: .buttonColor, background: .clear, fontSize: 14, fontWeight: .bold)
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 35
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(self.emailTextField)
        stackView.addArrangedSubview(self.passwordTextField)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        bindViewModel()
        setupGesture()
        regButton.tapButton = { [weak self] in
            guard let email = self?.emailTextField.text, !email.isEmpty,
                  let password = self?.passwordTextField.text, !password.isEmpty else {
                self?.alertOk(title: "Заполните все поля", message: nil)
                return
            }
            guard email.isValidEmail else {
                self?.alertOk(title: "Неверный формат email", message: "Проверьте email адрес")
                return
            }
            self?.viewModel.loginButtonDidTap(email: email, password: password)
        }
        signInButton.tapButton = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
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
//                self.viewModel.goToTabBar()
                print("initial")
            case .fail:
                self.alertOk(title: "Что-то пошло не так", message: "Возможно такой пользователь уже зарегестрирован")
            case .userNotFound:
                self.alertOk(title: "Пользователь не найден", message: nil)
            case .wrongPassword:
                self.alertOk(title: "Неверный пароль", message: nil)
            }
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(welcomeLabel)
        self.view.addSubview(stackView)
        self.view.addSubview(regButton)
        self.view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            
            self.welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.welcomeLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 96),
            
            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.welcomeLabel.bottomAnchor,constant: 80),
            self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.786),
            self.passwordTextField.heightAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 0.14),
            
            self.regButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 99),
            self.regButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.regButton.widthAnchor.constraint(equalTo: self.stackView.widthAnchor),
            self.regButton.heightAnchor.constraint(equalTo: self.regButton.widthAnchor, multiplier: 0.159),
            
            self.signInButton.topAnchor.constraint(equalTo: self.regButton.bottomAnchor, constant: 17),
            self.signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
}
