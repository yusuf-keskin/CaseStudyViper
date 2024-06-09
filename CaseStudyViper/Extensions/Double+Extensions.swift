//
//  Double+Extensions.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import Foundation

extension Double {
    
    func splitIntoParts(decimalPlaces: Int, round: Bool) -> (leftPart: Int, rightPart: Int) {
        
        var number = self
        if round {
            //round to specified number of decimal places:
            let divisor = pow(10.0, Double(decimalPlaces))
            number = Darwin.round(self * divisor) / divisor
        }
        
        //convert to string and split on decimal point:
        let parts = String(number).components(separatedBy: ".")
        
        //extract left and right parts:
        let leftPart = Int(parts[0]) ?? 0
        let rightPart = Int(parts[1]) ?? 0
        
        return(leftPart, rightPart)
        
    }
}

extension Double {
    func formatToCartPrice() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.numberStyle = .decimal
        
        let string = String(self)
        
        if let string = formatter.string(for: self) {
            return string                             // correctly results in “1,427.30” in US; “1.427,30” in Germany
        }
        return ""
    }
    
    func formatToPercentage() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        
        let string = String(self)
        
        if let string = formatter.string(for: self) {
            return string                             // correctly results in “1,427.30” in US; “1.427,30” in Germany
        }
        return ""
    }
}
