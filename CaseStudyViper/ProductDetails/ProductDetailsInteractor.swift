//
//  ProductDetailsInteractor.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 10.06.2024.
//

import Foundation

class ProductDetailsInteractor : ProductDetailsPresentorToInteractorProtocol {
    weak var presenter: (any ProductDetailsInteractorToPresentorProtocol)?

    let networkManager : NetworkManagerProtocol
    let productId: String
    
    init(networkManager: NetworkManagerProtocol, productId: String) {
        self.networkManager = networkManager
        self.productId = productId
    }
    
    private func fetchProduct(url: URL) async throws -> ProductDetailsModel {
        do {
            let productDetails = try await NetworkManager.shared.download(type:ProductDetailsModel.self, from: url)
            return productDetails
        } catch (let error) {
            throw ProductsListError.downloadError(receivedError: error)
        }
    }
    
    private func getProductDetailsURL() -> URL? {
        return URL(string: "http://private-d3ae2-n11case.apiary-mock.com/product?productId=\(productId)")
    }
    
    func fetchProductDetails() {
        Task {
            do {
                guard let url = getProductDetailsURL() else { return }
                let productDetails = try await fetchProduct(url: url)
                presenter?.interactorDidDownload(productsDetails: productDetails)

            } catch (let error ){
                presenter?.interactorDidDownloadWith(error: error)
            }
        }
    }
}
