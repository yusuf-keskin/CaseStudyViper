//
//  ProductsCollection_Entity.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import Foundation

// MARK: - ProductsListModel
struct ProductsCollectionModel: Codable {
    let page, nextPage, publishedAt: String
    let sponsoredProducts, regularProducts: [Product]
    
    enum CodingKeys: String, CodingKey {
        case page, nextPage
        case publishedAt = "published_at"
        case sponsoredProducts
        case regularProducts = "products"
    }
}

// MARK: - Product
struct Product: Codable, Equatable {
    let id: Int
    let title, image: String
    let price: Double
    let instantDiscountPrice, rate: Double?
    let sellerName: String?
}

enum ProductsListError : Error, LocalizedError {
    case downloadError(receivedError: Error?)
    case urlError(receivedError: Error?)
    
    var errorDescription: String {
        switch self {
            case .downloadError(let receivedError):
                return "Download products lists from api has failed, error: \(String(describing: receivedError?.localizedDescription))"
            case .urlError(let receivedError):
                return "Creating url from string file has failed, ,  error: \(String(describing: receivedError?.localizedDescription))"
        }
    }
    
}
