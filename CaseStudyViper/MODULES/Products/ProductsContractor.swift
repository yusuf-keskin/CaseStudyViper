//
//  ProductsContractor.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import Foundation
import UIKit

//MARK: - View will conform to:
protocol ProductsViewProtocol {
    var presenter : ProductsViewToPresenterDelegate? {get set}
}

///Presenter to view communication
protocol ProductsPresenterToViewDelegate: AnyObject {
    func reloadCollectionViewsWith(regularProducts : [Product], sponsoredProducts: [Product])
    func reloadCollectionViewsWith(error: NetworkingError)
}

//MARK: - Presenter will conform to:
protocol ProductsPresenterProtocol {
    var interactor : ProductsPresentorToInteractorDelegate? {get set}
    var view : ProductsPresenterToViewDelegate? {get set}
    var router : ProductsRouterProtocol? {get set}
}

///View to presenter communication
protocol ProductsViewToPresenterDelegate: AnyObject  {
    func viewDidLoad()
    func onReachToListEnd()
    func onTapCell(product : Product)
}

///Interactor to presenter communication
protocol ProductsInteractorToPresentorDelegate: AnyObject {
    func interactorDidDownloadWith(regularProducts : [Product], sponsoredProducts: [Product])
    func interactorDidDownloadWith(error: NetworkingError)
}

//MARK: - Interactor will conform to:
protocol ProductsInteractorProtocol {
    var presenter : ProductsInteractorToPresentorDelegate? {get set}
}

///Presenter to interactor communication
protocol ProductsPresentorToInteractorDelegate: AnyObject {
    func fetchProductsList()
}

//MARK: - Router will conform to:
///Presenter to router communication
protocol ProductsRouterProtocol {
    var entryPoint :  UINavigationController? {get set}
    func createModule() -> UINavigationController
    func routeToDetailsPageOf(productId: String) 
}

