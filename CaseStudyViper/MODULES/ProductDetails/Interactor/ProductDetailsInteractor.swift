//
//  ProductDetailsInteractor.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 10.06.2024.
//

import Foundation

final class ProductDetailsInteractor : ProductDetailsInteractorProtocol {
    weak var presenter: (any ProductDetailsInteractorToPresentorDelegate)?

    let networkManager : NetworkManagerProtocol
    let productId: String
    
    init(networkManager: NetworkManagerProtocol, productId: String) {
        self.networkManager = networkManager
        self.productId = productId
    }
    
    private func fetchProduct(url: URL) async throws -> ProductDetailsModel {
        do {
            let productDetails = try await networkManager.download(type:ProductDetailsModel.self, from: url)
            return productDetails
        } catch (let error) {
            throw error
        }
    }
    
    private func getProductDetailsURL() -> URL? {
        return URL(string: "http://private-d3ae2-n11case.apiary-mock.com/product?productId=\(productId)")
    }
}

extension ProductDetailsInteractor: ProductDetailsPresentorToInteractorDelegate {
    func fetchProductDetails() {
        Task {
            do {
                guard let url = getProductDetailsURL() else { return }
                let productDetails = try await fetchProduct(url: url)
                presenter?.interactorDidDownload(productsDetails: productDetails)
                
            } catch (let error ){
                presenter?.interactorDidDownloadWith(error: .downloadError(receivedError: error))
            }
        }
    }
}
