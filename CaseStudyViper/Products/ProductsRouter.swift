//
//  ProductsCollection_Router.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import UIKit

class ProductsRouter :ProductsRouterProtocol{
    
    func routeToDetailsPageOf(product: Product) {
        let postVC = UIViewController()
        postVC.view.backgroundColor = .red
        entryPoint?.present(postVC, animated: true)
    }
    
    
    // MARK: - Definitions
    weak var entryPoint: UIViewController?
    
    // MARK: - Create Module
    static func createModule() -> UIViewController {
        
        let view = ProductsViewController()
        let router = ProductsRouter()
        let presenter = ProductsPresenter()
        let interactor = ProductsInteractor(networkManager: NetworkManager.shared)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.entryPoint = view
        
        return view
    }
}

