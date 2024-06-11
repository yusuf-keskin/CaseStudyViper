//
//  ProductsViewController.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import UIKit

final class ProductsViewController: UIViewController {
    private var regularPoducts = [Product]()
    private var sponsoredProducts = [Product]()
    
    var presenter : ProductsViewToPresenterProtocol?
    
    private var activityView: UIActivityIndicatorView?
    
    private var attentionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bu ürünleri gördünüz mü?"
        label.textColor = .darkGray
        label.font = UIFont(name: "Avenir-Heavy", size: 16)
        label.isHidden = true
        return label
    }()
    
    private var sponsoredProductsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let regularProductCellNib = UINib(nibName: "SponsoredProductsCollectionViewCell", bundle: nil)
        collectionView.register(regularProductCellNib, forCellWithReuseIdentifier: "SponsoredProductsCollectionViewCell")
        return collectionView
    }()

    private var regularProductsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = #colorLiteral(red: 0.9601089015, green: 0.9601089015, blue: 0.9601089015, alpha: 1)
        let sponsoredProductCellNib = UINib(nibName: "RegularProductsCollectionViewCell", bundle: nil)
        collectionView.register(sponsoredProductCellNib, forCellWithReuseIdentifier: "RegularProductsCollectionViewCell")
        return collectionView
    }()
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light
        sponsoredProductsCollectionView.delegate = self
        sponsoredProductsCollectionView.dataSource = self
        regularProductsCollectionView.delegate = self
        regularProductsCollectionView.dataSource = self
        addSubviews()
        showActivityIndicator()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addSubviews() {
        view.addSubview(sponsoredProductsCollectionView)
        view.addSubview(regularProductsCollectionView)
        view.addSubview(attentionLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        attentionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        attentionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        attentionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        sponsoredProductsCollectionView.topAnchor.constraint(equalTo: attentionLabel.bottomAnchor, constant: 5).isActive = true
        sponsoredProductsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sponsoredProductsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sponsoredProductsCollectionView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        
        regularProductsCollectionView.topAnchor.constraint(equalTo: sponsoredProductsCollectionView.bottomAnchor).isActive = true
        regularProductsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        regularProductsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        regularProductsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    private func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    private func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
}

//MARK: - CollectionView Protocol Conformances
extension ProductsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == regularProductsCollectionView ? regularPoducts.count : sponsoredProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == regularProductsCollectionView {
            let regularProduct = regularPoducts[indexPath.item]
            let cell = regularProductsCollectionView
                .dequeueReusableCell(withReuseIdentifier: "RegularProductsCollectionViewCell",
                                     for: indexPath) as! RegularProductsCollectionViewCell
            cell.setupCell(regularProduct: regularProduct)
            return cell
        } else if collectionView == sponsoredProductsCollectionView {
            let sponsoredProduct = sponsoredProducts[indexPath.item]
            let cell = sponsoredProductsCollectionView
                .dequeueReusableCell(withReuseIdentifier: "SponsoredProductsCollectionViewCell",
                                     for:indexPath) as! SponsoredProductsCollectionViewCell
            cell.setupCellWith(sponsoredProduct: sponsoredProduct)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == regularProductsCollectionView {
            let width = collectionView.bounds.size.width/2 - 10
            let height = width * 2
            return CGSize(width: width, height: height)
        } else if collectionView == sponsoredProductsCollectionView {
            let width = collectionView.bounds.size.width - 10
            let height = width / 1.8
            return CGSize(width: width, height: height)
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == regularProductsCollectionView {
            if indexPath.item == regularPoducts.count - 1  {  //numberofitem count
                presenter?.onReachToListEnd()
            }
        } else if collectionView == sponsoredProductsCollectionView {
            if indexPath.item == sponsoredProducts.count - 1  {  //numberofitem count
                presenter?.onReachToListEnd()
            }
        } else {
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView == regularProductsCollectionView ? presenter?.onTapCell(product: regularPoducts[indexPath.item]) : presenter?.onTapCell(product: sponsoredProducts[indexPath.item])
    }
}

//MARK: - Presenter Protocols Conformances
extension ProductsViewController : ProductsPresenterToViewProtocol {
    
    func reloadCollectionViewsWith(error: NetworkingError) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            switch error {
                case .downloadError(receivedError: _):
                    showSimpleAlertWith(title: "Tekrar Deneyin", message: "Şu anda ürün bilgilerini alamıyoruz, lütfen daha sonra yeniden deneyin")
                case .urlError(receivedError: _):
                    print(error.errorDescription)
                case .lastPage:
                    showSimpleAlertWith(title: "Hergün yeni ürünler", message: "Yeni ürünler için bizi sık sık ziyaret etmeyi unutmayın")
            }
        }
    }

    func reloadCollectionViewsWith(regularProducts : [Product], sponsoredProducts: [Product]) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.sponsoredProducts.append(contentsOf: sponsoredProducts)
            self.regularPoducts.append(contentsOf: regularProducts)
            self.attentionLabel.isHidden = false
            self.hideActivityIndicator()
            self.regularProductsCollectionView.reloadData()
            self.sponsoredProductsCollectionView.reloadData()
        }
    }
}
