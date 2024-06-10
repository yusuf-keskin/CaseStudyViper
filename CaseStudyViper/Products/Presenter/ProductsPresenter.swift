//
//  ProductsCollection_Presenter.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import Foundation

class ProductsPresenter: ProductsViewToPresenterProtocol {
    
    var interactor : ProductsPresentorToInteractorProtocol?
    weak var view : ProductsPresenterToViewProtocol?
    var router : ProductsRouterProtocol?
    
    private var nextPage : String = "1"
    private var currentPage : String = "0"
    
    func viewDidLoad() {
        fetchProducts()
    }
    
    func onReachToListEnd() {
        fetchProducts()
    }
    
    func onTapCell(product: Product) {
        guard let id = product.id else { return }
        let idString = String(id)
        router?.routeToDetailsPageOf(productId: idString)
    }
    
    private func fetchProducts() {
        interactor?.fetchProductsList()
    }
}

extension ProductsPresenter: ProductsInteractorToPresentorProtocol {
    func interactorDidDownloadWith(error: any Error) {
        view?.reloadCollectionViewsWith(error: error)
    }
    
    func interactorDid(regularProducts: [Product], sponsoredProducts: [Product]) {
        view?.reloadCollectionViewsWith(regularProducts: regularProducts, sponsoredProducts: sponsoredProducts)
    }
}
