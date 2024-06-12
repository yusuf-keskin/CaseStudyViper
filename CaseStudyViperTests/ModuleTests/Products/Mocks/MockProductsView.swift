//
//  MockProductsView.swift
//  CaseStudyViperTests
//
//  Created by YUSUF KESKİN on 12.06.2024.
//

import Foundation
import XCTest
@testable import CaseStudyViper


class MockProductsView : ProductsPresenterToViewDelegate {
    
    var regularPr : [Product]?
    var sponsoredPr : [Product]?
    var error : NetworkingError?
    
    func reloadCollectionViewsWith(regularProducts: [Product], sponsoredProducts: [Product]) {
        regularPr = regularProducts
        sponsoredPr = sponsoredProducts
    }
    
    func reloadCollectionViewsWith(error:  NetworkingError) {
        self.error = error
    }
}
 
