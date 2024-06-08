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
    
    init(interactor: ProductsInteractor, view: ProductsViewInputs) {
        self.interactor = interactor
        self.view = view
    }
    
    
    func onTapCell() {}
    
    private func fetchProductsList() {
        Task {
            //TODO: Handle error here:
            do {
                guard let url = try? PRODUCTS_URL_STRING else { return }
                let productsList = try await interactor.fetchProducts(url: url)

                view.reloadCollectionViews(regularProducts: productsList.regularProducts, sponsoredProducts: productsList.sponsoredProducts)
            } catch (let error ){
                //TODO: Handle error (maybe indicator add?)
            }
        }
    }
    
    func viewDidLoad() {
        fetchProductsList()
    }
    
    func onCloseButtonTapped() {}
    
    func onReachBottom() {}
}
