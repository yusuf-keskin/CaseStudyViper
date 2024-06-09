//
//  Constants.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import Foundation
import UIKit


 func getProductsListLink(page : String ) -> URL? {
    guard let pageInt = Int(page) else { return nil}
    var components = URLComponents()
    components.scheme = "https"
    components.host = "private-d3ae2-n11case.apiary-mock.com"
    components.path = "/listing/\(page)"
    return components.url!
    }

