//
//  Labels+TextFields.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

class InfoLabels: UILabel {
    init(inform: String, size: CGFloat, weight: UIFont.Weight, color: UIColor) {
        super.init(frame: .zero)
        text = inform
        textColor = color
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        font = UIFont.systemFont(ofSize: size, weight: weight)
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class regTextField: UITextField {
    init(placeholderText: String, typeKeyBoard: UIKeyboardType, isSecureText: Bool) {
        super.init(frame: .zero)
        placeholder = placeholderText
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        backgroundColor = .earlGrey
        layer.cornerRadius = 15
        autocapitalizationType = .none
        textAlignment = .center
        keyboardType = typeKeyBoard
        isSecureTextEntry = isSecureText
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UIShowHideTextField: UITextField {

    lazy var rightButton: UIButton = {
        let rightButton = UIButton(type: .custom)
        rightButton.tintColor = .eyes
        rightButton.setImage(UIImage(systemName: "eye.slash") , for: .normal)
        rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
       return rightButton
    }()

    init() {
        super.init(frame: .zero)
        placeholder = "Password"
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        backgroundColor = .earlGrey
        layer.cornerRadius = 15
        autocapitalizationType = .none
        textAlignment = .center
        keyboardType = .emailAddress
        isSecureTextEntry = true
        rightViewMode = .always
        rightView = rightButton
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        leftView = paddingView
        leftViewMode = .always
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        super.rightViewRect(forBounds: bounds)
        let rightPoint = self.frame.maxX
        let origin = CGPoint(x: rightPoint-40, y: 5)
        let size = CGSize(width: 30, height: 35)
        return CGRect(origin: origin, size: size)
    }
    
    @objc func toggleShowHide() {
        isSecureTextEntry = !isSecureTextEntry
        if let existingText = text, isSecureTextEntry {
            rightButton.setImage(UIImage(systemName: "eye.slash") , for: .normal)
            deleteBackward()
            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingText)
            }
            if let existingSelectedTextRange = selectedTextRange {
                selectedTextRange = nil
                selectedTextRange = existingSelectedTextRange
            }
        } else {
            rightButton.setImage(UIImage(systemName: "eye") , for: .normal)
        }
    }
   
}
