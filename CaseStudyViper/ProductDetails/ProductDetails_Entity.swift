//
//  SingleProduct_Entity.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//


import Foundation

// MARK: - SingleProductModel
struct ProductDetailsModel: Codable {
    let title, description: String
    let images: [String]
    let price, instantDiscountPrice: Int
    let rate: Double
    let sellerName: String
}
