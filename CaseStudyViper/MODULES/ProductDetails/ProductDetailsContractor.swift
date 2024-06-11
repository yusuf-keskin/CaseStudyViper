//
//  ProductDetailsContractor.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 10.06.2024.
//

import Foundation
import UIKit

//MARK: - View will conform to:
///Presenter to view communication
protocol ProductDetailsPresenterToViewProtocol: AnyObject {
    var presenter: ProductDetailsViewToPresenterProtocol? {get set}
    func setupViewsWith(productsDetails : ProductDetailsModel)
    func setupViewsWith(error: NetworkingError)
}

//MARK: - Presenter will conform to:
///View to presenter communication
protocol ProductDetailsViewToPresenterProtocol: AnyObject {
    var interactor : ProductDetailsPresentorToInteractorProtocol? {get set}
    var view : ProductDetailsPresenterToViewProtocol? {get set}
    var router : ProductDetailsRouterProtocol? {get set}
    func viewDidLoad()
}

///Interactor to presenter communication
protocol ProductDetailsInteractorToPresentorProtocol: AnyObject {
    func interactorDidDownload(productsDetails : ProductDetailsModel)
    func interactorDidDownloadWith(error: NetworkingError)
}

//MARK: - Interactor will conform to:
///Presenter to interactor communication
protocol ProductDetailsPresentorToInteractorProtocol: AnyObject {
    var presenter : ProductDetailsInteractorToPresentorProtocol? {get set}
    func fetchProductDetails()
}

//MARK: - Router will conform to:
///Presenter to router communication
protocol ProductDetailsRouterProtocol {
    var entryPoint : UIViewController? {get set}
    func createModuleWith(productId: String) -> UIViewController
}
