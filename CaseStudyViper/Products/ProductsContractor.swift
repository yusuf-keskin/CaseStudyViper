//
//  ProductsContractor.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import Foundation
import UIKit

protocol NetworkManagerProtocol {
    func download<T:Decodable>(type: T.Type, from url: URL) async throws -> T
}

// View will confirm
protocol ProductsPresenterToViewProtocol: AnyObject {
    var presenter : ProductsViewToPresenterProtocol? {get set}
    func reloadCollectionViewsWith(regularProducts : [Product], sponsoredProducts: [Product])
    func reloadCollectionViewsWith(error: Error)
    func setupTableViewCell()
}

//Presenter will confirm
protocol ProductsViewToPresenterProtocol: AnyObject {
    var interactor : ProductsPresentorToInteractorProtocol? {get set}
    var view : ProductsPresenterToViewProtocol? {get set}
    var router : ProductsRouterProtocol? {get set}
    
    func viewDidLoad()
    func onReachToListEnd()
    func onTapCell(product : Product)
}

//Presenter will confirm
protocol ProductsInteractorToPresentorProtocol: AnyObject {
    func interactorDidDownloadProducts(regularProducts : [Product], sponsoredProducts: [Product])
    func interactorDidDownloadProducts(with error: Error)
}

//Interactor will confirm
protocol ProductsPresentorToInteractorProtocol: AnyObject {
    var presenter : ProductsInteractorToPresentorProtocol? {get set}
    func fetchProductsList() 
}

// Router Will Confirm
protocol ProductsRouterProtocol {
    var entryPoint :  UINavigationController? {get set}
    static func createModule() -> UINavigationController
    func routeToDetailsPageOf(product: Product)
}

