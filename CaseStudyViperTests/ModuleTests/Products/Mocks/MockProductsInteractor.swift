//
//  MockProductsInteractor.swift
//  CaseStudyViperTests
//
//  Created by YUSUF KESKİN on 12.06.2024.
//

import Foundation
@testable import CaseStudyViper
import XCTest

class MockProductsInteractor : ProductsPresentorToInteractorDelegate {
   
    weak var presenter : ProductsInteractorToPresentorDelegate?
    var expectation : XCTestExpectation?
    
    var errorOccured : Bool = false
    var fetchProductsListCalled : Bool = false
    
    func fetchProductsList() {
        fetchProductsListCalled = true
        switch errorOccured {
            case true:
                presenter?.interactorDidDownloadWith(error: NetworkingError.downloadError(receivedError: nil))
            case false:
                presenter?.interactorDidDownloadWith(regularProducts: test_regularProducts, sponsoredProducts: test_sponsoredProducts)
        }
    }
}
