//
//  ProductDetailsPresenter.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 10.06.2024.
//

import Foundation

final class ProductDetailsPresenter : ProductDetailsPresenterProtocol {
    var interactor : ProductDetailsPresentorToInteractorDelegate?
    weak var view : ProductDetailsPresenterToViewDelegate?
    var router : ProductDetailsRouterProtocol?
}

extension ProductDetailsPresenter : ProductDetailsViewToPresenterDelegate {
    func viewDidLoad() {
        interactor?.fetchProductDetails()
    }
}

extension ProductDetailsPresenter : ProductDetailsInteractorToPresentorDelegate {
    func interactorDidDownload(productsDetails: ProductDetailsModel) {
        view?.setupViewsWith(productsDetails: productsDetails)
    }
    
    func interactorDidDownloadWith(error: NetworkingError) {
        view?.setupViewsWith(error: error)
    }
}
