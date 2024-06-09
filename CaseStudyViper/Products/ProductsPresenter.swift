//
//  ProductsCollection_Presenter.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import Foundation

class ProductsPresenter: ProductsViewPresenterOutputs {
    
    let interactor : ProductsInteractor
    let view : ProductsViewInputs
    
    private var nextPage : String = "1"
    private var currentPage : String = "0"
    
    init(interactor: ProductsInteractor, view: ProductsViewInputs) {
        self.interactor = interactor
        self.view = view
    }

    func viewDidLoad() {
        fetchProducts()
    }
        
    func onReachToListEnd() {
        fetchProducts()
    }
    
    func onTapCell(product: Product) {
        dump(product)
    }
    
    private func fetchProducts() {
        Task {
            do {
                let (regularProducts, sponsoredProducts) = try await interactor.fetchProductsList()
                view.reloadCollectionViewsWith(regularProducts: regularProducts, sponsoredProducts: sponsoredProducts)
            } catch (let error ){
                view.reloadCollectionViewsWith(error: error)
            }
        }
    }
}
