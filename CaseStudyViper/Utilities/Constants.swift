//
//  Constants.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import Foundation

var PRODUCTS_URL_STRING : URL {
    get throws {
        guard let url = URL(string: "https://private-d3ae2-n11case.apiary-mock.com/listing/1") else {
            throw ProductsListError.urlError(receivedError: nil)
        }
        return url
    }
}

