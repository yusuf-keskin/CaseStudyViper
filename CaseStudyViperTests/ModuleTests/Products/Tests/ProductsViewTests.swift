//
//  ProductsViewTests.swift
//  CaseStudyViperTests
//
//  Created by YUSUF KESKİN on 13.06.2024.
//

import XCTest
@testable import CaseStudyViper

final class ProductsViewTests: XCTestCase {
    
    var sut : ProductsViewController!
    var mockPresenter : MockProductsPresenter!

    override func setUpWithError() throws {
        sut = ProductsViewController()
        mockPresenter = MockProductsPresenter()
    }

    override func tearDownWithError() throws {
        sut = nil
        mockPresenter = nil
    }

    func test_ProductsViewController_whenPresenterSendData_ViewGetsData() throws {
        sut.presenter = mockPresenter
        sut.viewDidLoad()
        XCTAssertTrue(mockPresenter.viewDidLoadCalled, "When viewDidLoad() called on the view it also should call viewDidLoad method of the presenter")
    }
}
