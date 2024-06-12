//
//  ProductsViewTests.swift
//  CaseStudyViperTests
//
//  Created by YUSUF KESKİN on 12.06.2024.
//

import XCTest
@testable import CaseStudyViper

final class ProductsPresenterTests: XCTestCase {
    
    var sut : ProductsPresenter!
    var mockInteractor : MockProductsInteractor!
    var mockView : MockProductsView!
    var mockProductsRouter : MockProductsRouter!

    override func setUpWithError() throws {
        sut = ProductsPresenter()
        mockView = MockProductsView()
        mockInteractor = MockProductsInteractor()
        mockProductsRouter = MockProductsRouter()
    }

    override func tearDownWithError() throws {
        sut = nil
        mockView = nil
        mockInteractor = nil
        mockProductsRouter = nil
    }

    func testProductPresenter_WhenViewDidLoadCalled_InteractorFetchProductsListMehodRuns() throws {
        mockInteractor = MockProductsInteractor()
        sut.interactor = mockInteractor
        sut.viewDidLoad()
        XCTAssertTrue(mockInteractor.fetchProductsListCalled, "Presenter's ViewDidLoad() method invokes interactor's fetchProductsList method" )
    }

    func testProductsPresenter_WhenOnReachToListEndCalled_InteractorFetchProductsListMehodRuns() throws {
        mockInteractor = MockProductsInteractor()
        sut.interactor = mockInteractor
        sut.onReachToListEnd()
        XCTAssertTrue(mockInteractor.fetchProductsListCalled, "Presenter's onReachToListEnd() method invokes interactor's fetchProductsList method" )
    }
    
    func testProductsPresenter_WhenOnTapCellCalled_RoutersRoutingMethodRuns()  throws {
        sut.router = mockProductsRouter
        sut.onTapCell(product: test_product)
        XCTAssertTrue(mockProductsRouter.routedToOtherPage, "When onTapCell() method invokes, it should invokes routers routeToDetailsPageOf method ")
    }
    
    func testProductsPresenter_WhenDataReceived_ViewGetsData()  throws {
        sut.view = mockView
        sut.interactorDidDownloadWith(regularProducts: test_regularProducts, sponsoredProducts: test_sponsoredProducts)
        
        XCTAssertNotNil(mockView.regularPr, "When presenter returns without error, regularPr shouldn't be nil")
        XCTAssertNotNil(mockView.sponsoredPr, "When presenter returns without error, sponsoredPr shouldn't be nil")
    }
    
    func testProductsPresenter_WhenErrorReceived_ViewGetsError()  throws {
        sut.view = mockView
        sut.interactorDidDownloadWith(error: NetworkingError.lastPage)
        
        XCTAssertNotNil(mockView.error, "When presenter returns error, view should get error")
    }
}
