//
//  ProductsInteractorTests.swift
//  CaseStudyViperTests
//
//  Created by YUSUF KESKİN on 13.06.2024.
//

import XCTest
@testable import CaseStudyViper

final class ProductsInteractorTests: XCTestCase {

    var sut : ProductsInteractor!
    var networkManager : NetworkManager!
    var mockPresenter : MockProductsPresenter!
    
    override func setUpWithError() throws {
        networkManager = NetworkManager()
        sut = ProductsInteractor(networkManager: networkManager)
        mockPresenter = MockProductsPresenter()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        networkManager = nil
        mockPresenter = nil
    }
    
    func testProductInteractor_fetchProductsListCalled_PresenterReceiveDataOrError() throws {
        let expectation = XCTestExpectation(description: "Interactor notifys presenter expoectation")
        sut.presenter = mockPresenter
        mockPresenter.expectation = expectation
        sut.fetchProductsList()
        self.wait(for: [expectation])
    }
    
}
