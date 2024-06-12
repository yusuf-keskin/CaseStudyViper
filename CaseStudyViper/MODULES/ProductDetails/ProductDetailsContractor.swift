//
//  ProductDetailsContractor.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 10.06.2024.
//

import Foundation
import UIKit

//MARK: - View will conform to:
protocol ProductDetailsViewProtocol {
    var presenter: ProductDetailsViewToPresenterDelegate? {get set}
}

///Presenter to view communication
protocol ProductDetailsPresenterToViewDelegate: AnyObject {
    func setupViewsWith(productsDetails : ProductDetailsModel)
    func setupViewsWith(error: NetworkingError)
}

//MARK: - Presenter will conform to:
protocol ProductDetailsPresenterProtocol {
    var interactor : ProductDetailsPresentorToInteractorDelegate? {get set}
    var view : ProductDetailsPresenterToViewDelegate? {get set}
    var router : ProductDetailsRouterProtocol? {get set}
}

///View to presenter communication
protocol ProductDetailsViewToPresenterDelegate: AnyObject {
    func viewDidLoad()
}

///Interactor to presenter communication
protocol ProductDetailsInteractorToPresentorDelegate: AnyObject {
    func interactorDidDownload(productsDetails : ProductDetailsModel)
    func interactorDidDownloadWith(error: NetworkingError)
}

//MARK: - Interactor will conform to:
protocol ProductDetailsInteractorProtocol {
    var presenter : ProductDetailsInteractorToPresentorDelegate? {get set}
}

///Presenter to interactor communication
protocol ProductDetailsPresentorToInteractorDelegate: AnyObject {
    func fetchProductDetails()
}

//MARK: - Router will conform to:
///Presenter to router communication
protocol ProductDetailsRouterProtocol {
    var entryPoint : UIViewController? {get set}
    func createModuleWith(productId: String) -> UIViewController
}
