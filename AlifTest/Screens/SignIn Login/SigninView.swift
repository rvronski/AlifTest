//
//  SignView.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

protocol SigninViewDelegate: AnyObject {
    func signButtonDidTap(email: String, name: String, password: String)
    func loginButtonDidTap()
    func showAlert()
    func showEmailAlert()
}

class SigninView: UIView {
    
    var delegate: SigninViewDelegate?
    
    private lazy var signInLabel = InfoLabels(inform: "Sign in", size: 30, weight: .bold, color: .black)
    
    private lazy var nameTextField = regTextField(placeholderText: "Name", typeKeyBoard: .default, isSecureText: false)

    private lazy var emailTextField = regTextField(placeholderText: "Email", typeKeyBoard: .emailAddress, isSecureText: false)
    
    private lazy var passwordTextField = UIShowHideTextField()
    
    private lazy var informLabel = InfoLabels(inform: "Already have an account?", size: 12, weight: .light, color: .gray)
    
    private lazy var enterButton = CustomButton(buttonText: "Sign in", textColor: .white, background: .buttonColor, fontSize: 20, fontWeight: .bold)
    
    private lazy var loginButton = CustomButton(buttonText: "Log in", textColor: .buttonColor, background: nil, fontSize: 14, fontWeight: .bold)
    
    private lazy var googleLabel = InfoLabels(inform: "Sign in with Google", size: 14, weight: .medium, color: .black)
    
    private lazy var appleLabel = InfoLabels(inform: "Sign in with Apple", size: 14, weight: .medium, color: .black)
    
    private lazy var googleImageView = CustomImageView(imageName: "googleLogo")
    
    private lazy var appleImageView = CustomImageView(imageName: "appleLogo")
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 35
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(self.nameTextField)
        stackView.addArrangedSubview(self.emailTextField)
        stackView.addArrangedSubview(self.passwordTextField)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        enterButton.tapButton = { [weak self] in
            guard  let name = self?.nameTextField.text, !name.isEmpty,
                   let email = self?.emailTextField.text, !email.isEmpty,
                   let password = self?.passwordTextField.text, !password.isEmpty else {
                self?.delegate?.showAlert()
                return
            }
            guard email.isValidEmail else {
                self?.delegate?.showEmailAlert()
                return
            }
            self?.delegate?.signButtonDidTap(email: email, name: name, password: password)
        }
        
        loginButton.tapButton = { [weak self] in
            self?.delegate?.loginButtonDidTap()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .backgroundColor
        self.addSubview(signInLabel)
        self.addSubview(stackView)
        self.addSubview(enterButton)
        self.addSubview(loginButton)
        self.addSubview(informLabel)
        self.addSubview(googleLabel)
        self.addSubview(appleLabel)
        self.addSubview(googleLabel)
        self.addSubview(appleLabel)
        self.addSubview(googleImageView)
        self.addSubview(appleImageView)
        
        
        NSLayoutConstraint.activate([
            self.signInLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.signInLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 96),
            
            self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.signInLabel.bottomAnchor,constant: 77),
            self.stackView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.786),
            self.nameTextField.heightAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 0.14),
            
            self.enterButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 35),
            self.enterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.enterButton.widthAnchor.constraint(equalTo: self.stackView.widthAnchor),
            self.enterButton.heightAnchor.constraint(equalTo: self.enterButton.widthAnchor, multiplier: 0.159),
            
            self.loginButton.topAnchor.constraint(equalTo: self.enterButton.bottomAnchor, constant: 17),
            self.loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.informLabel.centerYAnchor.constraint(equalTo: self.loginButton.centerYAnchor),
            self.informLabel.trailingAnchor.constraint(equalTo: self.loginButton.leadingAnchor, constant: -8),
            
            self.googleLabel.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor,constant: 80),
            self.googleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.appleLabel.topAnchor.constraint(equalTo: self.googleLabel.bottomAnchor,constant: 48),
            self.appleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.googleImageView.centerYAnchor.constraint(equalTo: self.googleLabel.centerYAnchor),
            self.googleImageView.trailingAnchor.constraint(equalTo: self.googleLabel.leadingAnchor, constant: -11),
            self.googleImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.064),
            self.googleImageView.heightAnchor.constraint(equalTo: self.googleImageView.widthAnchor),
            
            self.appleImageView.centerYAnchor.constraint(equalTo: self.appleLabel.centerYAnchor),
            self.appleImageView.trailingAnchor.constraint(equalTo: self.appleLabel.leadingAnchor, constant: -11),
            self.appleImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.064),
            self.appleImageView.heightAnchor.constraint(equalTo: self.appleImageView.widthAnchor, multiplier: 1.16),
            
            
        ])
        
    }
}
