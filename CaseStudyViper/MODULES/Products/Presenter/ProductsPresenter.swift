//
//  ProductsPresenter.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import Foundation

final class ProductsPresenter: ProductsPresenterProtocol {
    
    var interactor : ProductsPresentorToInteractorDelegate?
    weak var view : ProductsPresenterToViewDelegate?
    var router : ProductsRouterProtocol?
    
    private var nextPage : String = "1"
    private var currentPage : String = "0"

    private func fetchProducts() {
        interactor?.fetchProductsList()
    }
}

extension ProductsPresenter : ProductsViewToPresenterDelegate {
    func viewDidLoad() {
        fetchProducts()
    }
    
    func onReachToListEnd() {
        fetchProducts()
    }
    
    func onTapCell(product: Product) {
        let idString = String(product.id)
        router?.routeToDetailsPageOf(productId: idString)
    }
}

extension ProductsPresenter: ProductsInteractorToPresentorDelegate {
    func interactorDidDownloadWith(error: NetworkingError) {
        view?.reloadCollectionViewsWith(error: error)
    }
    
    func interactorDidDownloadWith(regularProducts: [Product], sponsoredProducts: [Product]) {
        view?.reloadCollectionViewsWith(regularProducts: regularProducts, sponsoredProducts: sponsoredProducts)
    }
}
