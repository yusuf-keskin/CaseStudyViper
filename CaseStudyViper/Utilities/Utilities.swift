//
//  Utilities.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import Foundation
import UIKit

func createDiscountRateString(price: Double?, discountedPrice: Double?) -> String? {
    guard let price = price else { return nil }
    guard let discountedPrice = discountedPrice else { return nil }
    let discountRate = (((discountedPrice / price) - 1) * -100).rounded()
    if discountRate == 0{
        return ""
    } else {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        
        if let rateString = formatter.string(for: discountRate) {
            guard rateString != "" else { return "" }
            return "%\(rateString)"
        }
        return ""
    }
}

