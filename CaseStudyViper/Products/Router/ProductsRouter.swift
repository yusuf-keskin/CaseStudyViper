//
//  ProductsCollection_Router.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import UIKit

class ProductsRouter :ProductsRouterProtocol{

    func routeToDetailsPageOf(productId: String) {
        let postVC = ProductDetailsRouter().createModuleWith(productId: productId)
        postVC.view.backgroundColor = .white
        entryPoint?.pushViewController(postVC, animated: true)
    }
    
    // MARK: - Definitions
    weak var entryPoint: UINavigationController?
    
    // MARK: - Create Module
    func createModule() -> UINavigationController {
        
        
        let view = ProductsViewController()
        let navController = UINavigationController(rootViewController: view)
        let router = ProductsRouter()
        let presenter = ProductsPresenter()
        let interactor = ProductsInteractor(networkManager: NetworkManager.shared)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.entryPoint = navController

        return navController
    }
}

