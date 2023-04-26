//
//  Color.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

extension UIColor {
    static var buttonColor: UIColor = #colorLiteral(red: 0.3052096963, green: 0.3318368793, blue: 0.8421060443, alpha: 1)
    static var backgroundColor: UIColor = #colorLiteral(red: 0.9803897738, green: 0.9764357209, blue: 1, alpha: 1)
    static var earlGrey: UIColor = #colorLiteral(red: 0.9098039269, green: 0.9098039269, blue: 0.9098039269, alpha: 1)
    static var eyes: UIColor = #colorLiteral(red: 0.3607842922, green: 0.3607842922, blue: 0.3607842922, alpha: 1)
    
   class func color(data: Data) -> UIColor? {
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
    }
    
    func encode() -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}

extension String {
    var isValidEmail: Bool {
            NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
        }
    }
