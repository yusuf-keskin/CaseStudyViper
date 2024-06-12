//
//  ProductDetailsViewController.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 9.06.2024.
//

import UIKit

final class ProductDetailsViewController: UIViewController {
    
    var presenter : ProductDetailsViewToPresenterDelegate?
    var imageURLs = [String]()
    private var activityView: UIActivityIndicatorView?
    
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var percentDiscountedPriceLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var chartDiscountedPriceLabel: UILabel!
    @IBOutlet weak var vendorNameLabel: UILabel!
    
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        setCollectionView()
        hideViews()
        showActivityIndicator()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setCollectionView() {
        imagesCollectionView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesCollectionViewCell")
    }
    
    @IBAction func buyNowButton(_ sender: Any) {}
    @IBAction func addToChartButton(_ sender: Any) {}
    
    private func setStarsFor(rating: Double?){
        guard let rating = rating else { return }
        guard rating < 6 else  { return }
        guard rating > 0 else {
            guard let views = ratingStackView.arrangedSubviews as? [UIImageView] else { return }
            for view in views {
                view.image = UIImage(systemName: "star")
                view.tintColor = .systemYellow
            }
            return
        }
        
        let ratinInt = Int(rating)
        
        guard let views = ratingStackView.arrangedSubviews as? [UIImageView] else { return }
        for i in 1...ratinInt {
            let view = views[(i-1)]
            view.image = UIImage(systemName: "star.fill")
            view.tintColor = .systemYellow
        }
    }
    
    private func hideViews() {
        percentageLabel.isHidden = true
        imagesCollectionView.isHidden = true
        productTitleLabel.isHidden = true
        ratingStackView.isHidden = true
        percentDiscountedPriceLabel.isHidden = true
        originalPriceLabel.isHidden = true
        chartDiscountedPriceLabel.isHidden = true
    }
    
    private func showViews() {
        percentageLabel.isHidden = false
        imagesCollectionView.isHidden = false
        productTitleLabel.isHidden = false
        ratingStackView.isHidden = false
        percentDiscountedPriceLabel.isHidden = false
        originalPriceLabel.isHidden = false
        chartDiscountedPriceLabel.isHidden = false
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
extension ProductDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
        let urlString = imageURLs[indexPath.item]
        guard let url = URL(string: urlString) else {return UICollectionViewCell()}
        cell.setImageFrom(url: url)
        return cell
    }
    
}

extension ProductDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        return CGSize(width: width, height: height)
    }
}

//MARK: - Presenter Protocols Conformances
extension ProductDetailsViewController : ProductDetailsPresenterToViewDelegate {
    
    func setupViewsWith(productsDetails: ProductDetailsModel) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            hideActivityIndicator()
            imageURLs = productsDetails.images
            productTitleLabel.text = productsDetails.title
            setStarsFor(rating: productsDetails.rate)
            
            if let price = productsDetails.price {
                let priceString = price.createPriceString()
                originalPriceLabel.attributedText = priceString.crateLinedString()
            }
            
            if let instantDiscountPrice = productsDetails.instantDiscountPrice {
                let priceString = instantDiscountPrice.createPriceString()
                percentDiscountedPriceLabel.text = priceString
                
                let chartDiscountedPrice = instantDiscountPrice - 150
                chartDiscountedPriceLabel.text = chartDiscountedPrice.createPriceString()
            }
            
            guard let discountRate = createDiscountRateString(price: productsDetails.price, discountedPrice: productsDetails.instantDiscountPrice) else { return }
            percentageLabel.text = discountRate
            
            vendorNameLabel.text = productsDetails.sellerName

            imagesCollectionView.reloadData()
            showViews()
        }
        
    }
    
    func setupViewsWith(error: NetworkingError) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            switch error {
                case .downloadError(receivedError: _):
                    showSimpleAlertWith(title: "Tekrar Deneyin", message: "Şu anda ürün bilgilerini alamıyoruz, lütfen daha sonra yeniden deneyin")
                case .urlError(receivedError: _):
                    print(error.errorDescription)
                case .lastPage:
                    return
                case .responseError:
                    return
            }
        }
    }
}
