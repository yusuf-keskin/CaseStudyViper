//
//  MockProductsPresenter.swift
//  CaseStudyViperTests
//
//  Created by YUSUF KESKİN on 12.06.2024.
//

import Foundation
import XCTest
@testable import CaseStudyViper

class MockProductsPresenter : ProductsInteractorToPresentorDelegate {
    
    var interactor : ProductsPresentorToInteractorDelegate?
    var router : ProductsRouterProtocol?
    
    var viewDidLoadCalled : Bool = false
    
    var expectation : XCTestExpectation?
    
    weak var view : ProductsPresenterToViewDelegate?
    
    func interactorDidDownloadWith(regularProducts: [Product], sponsoredProducts: [Product]) {
        expectation?.fulfill()
        view?.reloadCollectionViewsWith(regularProducts: test_regularProducts, sponsoredProducts: test_sponsoredProducts)
    }
    
    func interactorDidDownloadWith(error: NetworkingError) {
        expectation?.fulfill()
        view?.reloadCollectionViewsWith(error: NetworkingError.responseError)
    }
}


extension MockProductsPresenter : ProductsViewToPresenterDelegate {
    func viewDidLoad() {
        viewDidLoadCalled = true
        interactor?.fetchProductsList()
    }
    
    func onReachToListEnd() {
        interactor?.fetchProductsList()
    }
    
    func onTapCell(product: CaseStudyViper.Product) {
        
    }
}
