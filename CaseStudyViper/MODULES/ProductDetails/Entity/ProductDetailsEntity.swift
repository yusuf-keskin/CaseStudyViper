//
//  SingleProduct_Entity.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//


import Foundation

// MARK: - SingleProductDetailsModel
struct ProductDetailsModel: Codable {
    let title, description: String
    let images: [String]
    let price, instantDiscountPrice: Double?
    let rate: Double
    let sellerName: String
}
