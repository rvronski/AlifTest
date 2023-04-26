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
    
//   class func color(data: Data) -> UIColor {
//        return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! UIColor
//    }
//
//    func encode() -> Data {
//        return try! NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
//    }
    
//    convenience init?(hex: String) {
//            var hexNormalized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
//            hexNormalized = hexNormalized.replacingOccurrences(of: "#", with: "")
//
//            // Helpers
//            var rgb: UInt32 = 0
//            var r: CGFloat = 0.0
//            var g: CGFloat = 0.0
//            var b: CGFloat = 0.0
//            var a: CGFloat = 1.0
//            let length = hexNormalized.characters.count
//
//            // Create Scanner
//            Scanner(string: hexNormalized).scanHexInt32(&rgb)
//
//            if length == 6 {
//                r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
//                g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
//                b = CGFloat(rgb & 0x0000FF) / 255.0
//
//            } else if length == 8 {
//                r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
//                g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
//                b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
//                a = CGFloat(rgb & 0x000000FF) / 255.0
//
//            } else {
//                return nil
//            }
//
//            self.init(red: r, green: g, blue: b, alpha: a)
//        }
//    var toHex: String? {
//           // Extract Components
//           guard let components = cgColor.components, components.count >= 3 else {
//               return nil
//           }
//
//           // Helpers
//           let r = Float(components[0])
//           let g = Float(components[1])
//           let b = Float(components[2])
//           var a = Float(1.0)
//
//           if components.count >= 4 {
//               a = Float(components[3])
//           }
//
//           // Create Hex String
//           let hex = String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
//
//           return hex
//       }
//

}

extension String {
    var isValidEmail: Bool {
            NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
        }
    }
