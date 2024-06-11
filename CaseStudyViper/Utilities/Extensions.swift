//
//  Extensions.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import Foundation
import UIKit

extension Double {
    func formatToCartPriceString() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .decimal
        
        if let string = formatter.string(for: self) {
            return "\(string) TL"
        }
        return ""
    }
    
    func formatToPercentageString() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
                
        if let string = formatter.string(for: self) {
            return string
        }
        return ""
    }
}

extension UIViewController {
    func showSimpleAlertWith(title: String, message: String) {
        let alertContreoller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default)
        alertContreoller.addAction(okButton)
        present(alertContreoller, animated: true)
    }
}
