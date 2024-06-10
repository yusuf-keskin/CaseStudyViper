//
//  Constants.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import Foundation
import UIKit


func getProductsListLink(page : String ) -> URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "private-d3ae2-n11case.apiary-mock.com"
    components.path = "/listing/\(page)"
    return components.url!
}

func crateLinedStringFromDouble(price : Double) -> NSAttributedString {
    let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(price)")
    attributeString.addAttribute(
        NSAttributedString.Key.strikethroughStyle,
        value: 2,
        range: NSRange(location: 0, length: attributeString.length))
    return attributeString
}


func createDiscountRateLabelString(price: Double?, discountedPrice: Double?) -> String? {
    guard let price = price else { return nil }
    guard let discountedPrice = discountedPrice else { return nil }
    let discountRate = (((discountedPrice / price) - 1) * -100).rounded().formatToPercentage()
    return "%\(discountRate)"
}
