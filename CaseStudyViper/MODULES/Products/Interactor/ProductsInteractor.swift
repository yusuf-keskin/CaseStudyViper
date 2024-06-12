//
//  ProductsInteractor.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import Foundation

final class ProductsInteractor: ProductsInteractorProtocol {
    
    private var nextPage : String = "1"
    private var currentPage : String = "0"
    
    weak var presenter : ProductsInteractorToPresentorDelegate?
    let networkManager : NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    private func fetchProducts(url: URL) async throws -> ProductsCollectionModel {
        do {
            let productList = try await networkManager.download(type:ProductsCollectionModel.self, from: url)
            return productList
        } catch (let error) {
            throw error
        }
    }  
    
    private func getProductsListLink(page : String ) -> URL? {
        guard let _ = Int(page) else { return nil}
        var components = URLComponents()
        components.scheme = "https"
        components.host = "private-d3ae2-n11case.apiary-mock.com"
        components.path = "/listing/\(page)"
        return components.url!
    }    
}

extension ProductsInteractor : ProductsPresentorToInteractorDelegate {
    func fetchProductsList() {
        Task {
            do {
                if currentPage == nextPage {
                    presenter?.interactorDidDownloadWith(error: NetworkingError.lastPage)
                    return
                }
                
                guard let url = getProductsListLink(page: nextPage) else { throw NetworkingError.urlError(receivedError: nil) }
                print("Network reguest")
                let productsList = try await fetchProducts(url: url)
                var regularProductsArray = [Product]()
                var sponsoredProductsArray = [Product]()
                
                regularProductsArray = productsList.regularProducts

                if let unwappedSponsoredProducts = productsList.sponsoredProducts {
                    sponsoredProductsArray = unwappedSponsoredProducts
                }
                
                if let newNextPage = productsList.nextPage {
                    nextPage = newNextPage
                }

                    currentPage = productsList.page

                presenter?.interactorDidDownloadWith(regularProducts: regularProductsArray, sponsoredProducts: sponsoredProductsArray)
            } catch (let error ){
                presenter?.interactorDidDownloadWith(error: .downloadError(receivedError: error))
            }
        }
    }
}
