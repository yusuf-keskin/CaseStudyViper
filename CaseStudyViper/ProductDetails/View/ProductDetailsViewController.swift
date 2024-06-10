//
//  ProductDetailsVCViewController.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 9.06.2024.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    var presenter : ProductDetailsViewToPresenterProtocol?
    var imageURLs = [String]()
    
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var ratingView: UIStackView!
    @IBOutlet weak var percentDiscountedPriceLabel: UILabel!
    @IBOutlet weak var originalPrice: UILabel!
    @IBOutlet weak var chartDiscountedPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        setCollectionView()
        presenter?.viewDidLoad()
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
            guard let views = ratingView.arrangedSubviews as? [UIImageView] else { return }
            for view in views {
                view.image = UIImage(systemName: "star")
                view.tintColor = .systemYellow
            }
            return
        }
        
        let ratinInt = Int(rating)
        
        guard let views = ratingView.arrangedSubviews as? [UIImageView] else { return }
        for i in 1...ratinInt {
            let view = views[(i-1)]
            view.image = UIImage(systemName: "star.fill")
            view.tintColor = .systemYellow
        }
    }
}

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

extension ProductDetailsViewController : ProductDetailsPresenterToViewProtocol {
    
    func setupViewsWith(productsDetails: ProductDetailsModel) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            imageURLs = productsDetails.images
            productTitleLabel.text = productsDetails.title
            setStarsFor(rating: productsDetails.rate)
            if let price = productsDetails.price {
                let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(price)")
                attributeString.addAttribute(
                    NSAttributedString.Key.strikethroughStyle,
                    value: 2,
                    range: NSRange(location: 0, length: attributeString.length))
                originalPrice.attributedText = attributeString
            }
            
            if let instantDiscountPrice = productsDetails.instantDiscountPrice {
                percentDiscountedPriceLabel.text = instantDiscountPrice.formatToCartPrice()
            }
            
            guard let discountRate = createDiscountRateLabelString(price: productsDetails.price, discountedPrice: productsDetails.instantDiscountPrice) else { return }
            percentageLabel.text = discountRate
            imagesCollectionView.reloadData()
        }

    }
    
    func setupViewsWith(error: any Error) {

    }
    
    
}
