//
//  ProductDetailsRouter.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 10.06.2024.
//

import Foundation
import UIKit

class ProductDetailsRouter : ProductDetailsRouterProtocol {
    
    weak var entryPoint: UIViewController?
    var productId: String?
    
    func createModuleWith(productId: String) -> UIViewController {
        
        let view = ProductDetailsViewController()
        let router = ProductDetailsRouter()
        let presenter = ProductDetailsPresenter()
        let interactor = ProductDetailsInteractor(networkManager: NetworkManager.shared, productId: productId)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.entryPoint = view
        
        return view
    }
    
    func routeToDetailsPageOf(product: Product) {
        
    }
}
