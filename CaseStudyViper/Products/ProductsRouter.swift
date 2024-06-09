//
//  ProductsCollection_Router.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import UIKit


struct ProductsRouter: ProductsRouterProtocol  {
    var entryPoint: UINavigationController?
    
    var navigationController: UINavigationController? = UINavigationController()
    
    func startExecution() -> ProductsRouter {
        var router = ProductsRouter()
        let view = ProductsViewController()
        let presenter = ProductsPresenter()
        let interactor = ProductsInteractor(networkManager: NetworkManager.shared)

        let navController = UINavigationController(rootViewController: view)
        
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        
        router.entryPoint = navController
        return router
    }
    
    
    func routeTo(){
        
    }
    
}
