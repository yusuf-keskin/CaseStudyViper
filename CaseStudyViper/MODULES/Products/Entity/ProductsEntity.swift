//
//  ProductsEntity.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import Foundation

struct ProductsCollectionModel : Codable {
    let page : String
    let nextPage : String?
    let published_at : String?
    let sponsoredProducts : [Product]?
    let regularProducts : [Product]
    
    enum CodingKeys: String, CodingKey {
        
        case page = "page"
        case nextPage = "nextPage"
        case published_at = "published_at"
        case sponsoredProducts = "sponsoredProducts"
        case regularProducts = "products"
    }
    
    init(page: String, nextPage: String?, published_at: String?, sponsoredProducts: [Product]?, regularProducts: [Product]) {
        self.page = page
        self.nextPage = nextPage
        self.published_at = published_at
        self.sponsoredProducts = sponsoredProducts
        self.regularProducts = regularProducts
    }
}

extension ProductsCollectionModel {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(String.self, forKey: .page)
        nextPage = try values.decodeIfPresent(String.self, forKey: .nextPage)
        published_at = try values.decodeIfPresent(String.self, forKey: .published_at)
        sponsoredProducts = try values.decodeIfPresent([Product].self, forKey: .sponsoredProducts)
        regularProducts = try values.decode([Product].self, forKey: .regularProducts)
    }
}

struct Product : Codable {
    let id : Int
    let title : String
    let image : String?
    let price : Double?
    let instantDiscountPrice : Double?
    let rate : Double?
    let sellerName : String?
    
    init(id: Int, title: String, image: String?, price: Double?, instantDiscountPrice: Double?, rate: Double?, sellerName: String?) {
        self.id = id
        self.title = title
        self.image = image
        self.price = price
        self.instantDiscountPrice = instantDiscountPrice
        self.rate = rate
        self.sellerName = sellerName
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case image = "image"
        case price = "price"
        case instantDiscountPrice = "instantDiscountPrice"
        case rate = "rate"
        case sellerName = "sellerName"
    }
    

}

extension Product {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        instantDiscountPrice = try values.decodeIfPresent(Double.self, forKey: .instantDiscountPrice)
        rate = try values.decodeIfPresent(Double.self, forKey: .rate)
        sellerName = try values.decodeIfPresent(String.self, forKey: .sellerName)
    }
}
