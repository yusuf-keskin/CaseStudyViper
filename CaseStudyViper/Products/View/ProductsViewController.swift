//
//  ProductsViewController.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import UIKit

class ProductsViewController: UIViewController {
    private var regularPoducts = [Product]()
    private var sponsoredProducts = [Product]()
    
    //TODO: Build real collectionview uı
    private var sponsoredProductsCollectionView : UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return UICollectionView()
    }()
    
    //TODO: Build real collectionview uı
    private var regularProductsCollectionView : UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return UICollectionView()
    }()
    
    lazy var presenter  : ProductsPresenter = .init(interactor: ProductsInteractor(), view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        sponsoredProductsCollectionView.delegate = self
        sponsoredProductsCollectionView.dataSource = self
        regularProductsCollectionView.delegate = self
        regularProductsCollectionView.dataSource = self
        addSubviews()
        presenter.viewDidLoad()
    }
    
    private func addSubviews() {
        view.addSubview(sponsoredProductsCollectionView)
        view.addSubview(regularProductsCollectionView)
    }
}

extension ProductsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == sponsoredProductsCollectionView ? sponsoredProducts.count : regularPoducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let promotedProduct = sponsoredProducts[indexPath.item]
        let regularProduct = regularPoducts[indexPath.item]
        
        //TODO: Implement cell configures
        
        
        return UICollectionViewCell()
    }
}

extension ProductsViewController : ProductsViewInputs {
    func configure() {}
   
    @MainActor
    func reloadCollectionViews(regularProducts : [Product], sponsoredProducts: [Product]) {
        self.sponsoredProducts = sponsoredProducts
        self.regularPoducts = regularProducts
        
        //TODO: Reload collection view controllers here
    }
    
    func setupTableViewCell() {}
    
    func indicatorView(animate: Bool) {}
    
    func sortByTitle() {}
    
    
}
