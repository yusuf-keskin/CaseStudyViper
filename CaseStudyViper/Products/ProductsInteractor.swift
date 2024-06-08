//
//  ProductsCollection_Interactor.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import Foundation

class ProductsInteractor {
    
    func fetchProducts(url: URL) async throws -> ProductsCollectionModel {
        do {
            let productList = try await NetworkManager.download(type:ProductsCollectionModel.self, from: url)
            return productList
        } catch (let error) {
            throw ProductsListError.downloadError(receivedError: error)
        }
    }
}
