//
//  ProductDetailsPresenter.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 10.06.2024.
//

import Foundation

final class ProductDetailsPresenter : ProductDetailsViewToPresenterProtocol {
    var interactor : ProductDetailsPresentorToInteractorProtocol?
    weak var view : ProductDetailsPresenterToViewProtocol?
    var router : ProductDetailsRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchProductDetails()
    }
}

extension ProductDetailsPresenter : ProductDetailsInteractorToPresentorProtocol {
    func interactorDidDownload(productsDetails: ProductDetailsModel) {
        view?.setupViewsWith(productsDetails: productsDetails)
    }
    
    func interactorDidDownloadWith(error: NetworkingError) {
        view?.setupViewsWith(error: error)
    }
}
