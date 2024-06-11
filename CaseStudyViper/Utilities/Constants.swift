//
//  Constants.swift
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
    if discountRate <= 1 {
        
    } else {
        let rateString = discountRate.formatToPercentageString()
        return "%\(rateString)"
    }
    return ""
}

func crateLinedStringFrom(string : String) -> NSAttributedString {
    let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: string)
    attributeString.addAttribute(
        NSAttributedString.Key.strikethroughStyle,
        value: 2,
        range: NSRange(location: 0, length: attributeString.length))
    return attributeString
}
