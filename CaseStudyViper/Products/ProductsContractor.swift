//
//  ProductsContractor.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import Foundation

//Products view interface
protocol ProductsInteractorOutputs {
    func onSuccessSearch()
    func onErrorSearch()
}

//Products presenter interface
protocol ProductsViewInputs {
    func configure()
    func reloadCollectionViews(regularProducts : [Product], sponsoredProducts: [Product])
    func setupTableViewCell()
    func indicatorView(animate: Bool)
    func sortByTitle()
}


protocol ProductsViewPresenterOutputs {
    func viewDidLoad()
    func onCloseButtonTapped()
    func onReachBottom()
    func onTapCell()
}
