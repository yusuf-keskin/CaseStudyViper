//
//  ProductsCollection_Interactor.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import Foundation

class ProductsInteractor: ProductsPresentorToInteractorProtocol {
    
    private var nextPage : String = "1"
    private var currentPage : String = "0"
    
    weak var presenter : ProductsInteractorToPresentorProtocol?
    let networkManager : NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    private func fetchProducts(url: URL) async throws -> ProductsCollectionModel {
        do {
            let productList = try await NetworkManager.shared.download(type:ProductsCollectionModel.self, from: url)
            return productList
        } catch (let error) {
            throw ProductsListError.downloadError(receivedError: error)
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
    
    func fetchProductsList() {
            Task {
                do {
                    if currentPage == nextPage { throw ProductsListError.lastPage }
                    guard let url = getProductsListLink(page: nextPage) else { throw ProductsListError.urlError(receivedError: nil) }
                    print("Network reguest")
                    let productsList = try await fetchProducts(url: url)
                    var regularProductsArray = [Product]()
                    var sponsoredProductsArray = [Product]()
                    
                    if let unwappedRegularProducts = productsList.regularProducts {
                        regularProductsArray = unwappedRegularProducts
                    }
                    
                    if let unwappedSponsoredProducts = productsList.sponsoredProducts {
                        sponsoredProductsArray = unwappedSponsoredProducts
                    }
                    
                    if let newNextPage = productsList.nextPage {
                        nextPage = newNextPage
                    }
                    
                    if let newCurentPage = productsList.page {
                        currentPage = newCurentPage
                    }
                    
                    presenter?.interactorDid(regularProducts: regularProductsArray, sponsoredProducts: sponsoredProductsArray)
                } catch (let error ){
                    presenter?.interactorDidDownloadWith(error: error)
                }
            }
    }
}

