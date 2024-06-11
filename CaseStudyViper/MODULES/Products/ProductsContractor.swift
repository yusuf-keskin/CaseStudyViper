//
//  ProductsContractor.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import Foundation
import UIKit



//MARK: - View will conform to:
///Presenter to view communication
protocol ProductsPresenterToViewProtocol: AnyObject {
    var presenter : ProductsViewToPresenterProtocol? {get set}
    func reloadCollectionViewsWith(regularProducts : [Product], sponsoredProducts: [Product])
    func reloadCollectionViewsWith(error: NetworkingError)
}

//MARK: - Presenter will conform to:
protocol ProductsViewToPresenterProtocol: AnyObject {
    ///View to presenter communication
    var interactor : ProductsPresentorToInteractorProtocol? {get set}
    var view : ProductsPresenterToViewProtocol? {get set}
    var router : ProductsRouterProtocol? {get set}
    
    func viewDidLoad()
    func onReachToListEnd()
    func onTapCell(product : Product)
}

///Interactor to presenter communication
protocol ProductsInteractorToPresentorProtocol: AnyObject {
    func interactorDid(regularProducts : [Product], sponsoredProducts: [Product])
    func interactorDidDownloadWith(error: NetworkingError)
}

//MARK: - Interactor will conform to:
///Presenter to interactor communication
protocol ProductsPresentorToInteractorProtocol: AnyObject {
    var presenter : ProductsInteractorToPresentorProtocol? {get set}
    func fetchProductsList()
}

//MARK: - Router will conform to:
///Presenter to router communication
protocol ProductsRouterProtocol {
    var entryPoint :  UINavigationController? {get set}
    func createModule() -> UINavigationController
    func routeToDetailsPageOf(productId: String) 
}

