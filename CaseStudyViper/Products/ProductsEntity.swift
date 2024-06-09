//
//  ProductsCollection_Entity.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import Foundation

enum ProductsListError : Error, LocalizedError {
    case downloadError(receivedError: Error?)
    case urlError(receivedError: Error?)
    case lastPage
    
    var errorDescription: String {
        switch self {
            case .downloadError(let receivedError):
                return "Download products lists from api has failed, error: \(String(describing: receivedError?.localizedDescription))"
            case .urlError(let receivedError):
                return "Creating url from string file has failed, ,  error: \(String(describing: receivedError?.localizedDescription))"
            case .lastPage:
                return "No more data in the endpoint to load"
        }
    }
    
}

struct ProductsCollectionModel : Codable {
    let page : String?
    let nextPage : String?
    let published_at : String?
    let sponsoredProducts : [Product]?
    let regularProducts : [Product]?
    
    enum CodingKeys: String, CodingKey {
        
        case page = "page"
        case nextPage = "nextPage"
        case published_at = "published_at"
        case sponsoredProducts = "sponsoredProducts"
        case regularProducts = "products"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(String.self, forKey: .page)
        nextPage = try values.decodeIfPresent(String.self, forKey: .nextPage)
        published_at = try values.decodeIfPresent(String.self, forKey: .published_at)
        sponsoredProducts = try values.decodeIfPresent([Product].self, forKey: .sponsoredProducts)
        regularProducts = try values.decodeIfPresent([Product].self, forKey: .regularProducts)
    }
}

struct Product : Codable {
    let id : Int?
    let title : String?
    let image : String?
    let price : Double?
    let instantDiscountPrice : Double?
    let rate : Double?
    let sellerName : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case image = "image"
        case price = "price"
        case instantDiscountPrice = "instantDiscountPrice"
        case rate = "rate"
        case sellerName = "sellerName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        instantDiscountPrice = try values.decodeIfPresent(Double.self, forKey: .instantDiscountPrice)
        rate = try values.decodeIfPresent(Double.self, forKey: .rate)
        sellerName = try values.decodeIfPresent(String.self, forKey: .sellerName)
    }
}

//struct SponsoredProduct : Codable {
//    let id : Int?
//    let title : String?
//    let image : String?
//    let price : Double?
//    let instantDiscountPrice : Double?
//    let rate : Double?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case id = "id"
//        case title = "title"
//        case image = "image"
//        case price = "price"
//        case instantDiscountPrice = "instantDiscountPrice"
//        case rate = "rate"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//        image = try values.decodeIfPresent(String.self, forKey: .image)
//        price = try values.decodeIfPresent(Double.self, forKey: .price)
//        instantDiscountPrice = try values.decodeIfPresent(Double.self, forKey: .instantDiscountPrice)
//        rate = try values.decodeIfPresent(Double.self, forKey: .rate)
//    }
//    
//}
