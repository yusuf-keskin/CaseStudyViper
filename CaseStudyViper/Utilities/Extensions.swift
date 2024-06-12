//
//  Extensions.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import Foundation
import UIKit

extension Double {
/// Create a string from double with two digit after .
    func createPriceString() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .decimal
        
        if let string = formatter.string(for: self) {
            return "\(string) TL"
        }
        return ""
    }
}

extension UIViewController {
    
    /// presents simple alert screen with title, message and "ok" button
    func showSimpleAlertWith(title: String, message: String) {
        let alertContreoller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default)
        alertContreoller.addAction(okButton)
        present(alertContreoller, animated: true)
    }
}

extension String {
    
    /// Draw horizontal line onto the string
    func crateLinedString() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: 2,
            range: NSRange(location: 0, length: attributeString.length))
        return attributeString
    }
}
