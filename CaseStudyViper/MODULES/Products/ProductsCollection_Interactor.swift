//
//  ProductsCollection_Interactor.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import Foundation

protocol ProductsCollection_Interactor : AnyObject{
    var presenter : ProductsCollection_Presenter? { get set }
    func downloadProductsList()
}

class ProductsInteractor: ProductsCollection_Interactor {
    weak var presenter: ProductsCollection_Presenter?
    
    private var nextPage : Int? = 1
    
    func downloadProductsList(){
        
        guard nextPage != nil else {
            print("no more pages left")
            return
        }
        
        let urlString = "https://private-d3ae2-n11case.apiary-mock.com/listing/1"
        guard let url = URL(string: urlString) else { return }
        
        Task { [weak self] in
            do {
                let productList = try await NetworkManager.download(type: ProductsCollectionModel.self, from: url)
                self?.presenter?.interactorDidDownloadProductsList(result: .success(productList.products))
            } catch (let error) {
                
            }
        }
        
        
//        session.dataTask(with: request) { [weak self] data, response, error in
//            
//            guard error != nil else {
//                self?.presenter?.interactorDidDownloadProductsList(result: .failure(ProductsListError.downloadError))
//                print(error?.localizedDescription as Any)
//                return
//            }
//            
//            
//            
//        }.resume()
    }
}
