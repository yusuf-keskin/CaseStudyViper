//
//  MockProductsRouter.swift
//  CaseStudyViperTests
//
//  Created by YUSUF KESKİN on 12.06.2024.
//

import Foundation
@testable import CaseStudyViper
import UIKit

class MockProductsRouter : ProductsRouterProtocol {
    
    var routedToOtherPage = false
    
    var entryPoint: UINavigationController?
    
    func createModule() -> UINavigationController {
        let navigationController = UINavigationController()
        self.entryPoint = navigationController
        return navigationController
    }
    
    func routeToDetailsPageOf(productId: String) {
        routedToOtherPage = true
    }
    
    
}
