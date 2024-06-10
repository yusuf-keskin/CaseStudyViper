//
//  CollectionViewCell.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import UIKit
import Kingfisher

class RegularProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var whiteBackgroundView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    @IBOutlet weak var ratingView: UIStackView!
    
    @IBOutlet weak var discountPercentageLabel: UILabel!
    @IBOutlet weak var defaultPriceLabel: UILabel!
    @IBOutlet weak var percentageDiscountedPriceLabel: UILabel!
    @IBOutlet weak var additionalDiscountAtCartTitleLabel: UILabel!
    @IBOutlet weak var discountedAtCartPriceLabel: UILabel!
    @IBOutlet weak var vendorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
    }
    
    @MainActor
    func setupCell(regularProduct:Product){
        if let urlString = regularProduct.image {
            if  let url = URL(string:urlString) {
                productImageView.kf.setImage(with: url)
            }
        }
        productTitleLabel.text = regularProduct.title
        setStarsFor(rating: regularProduct.rate)
        if let price = regularProduct.price {
            let attributeString = crateLinedStringFromDouble(price: price)
            defaultPriceLabel.attributedText = attributeString
        }
        if let unwrappedRegularPrice = regularProduct.price {
            let percentageDiscounterPrice = Double(round(100 * (unwrappedRegularPrice * 0.96)) / 100)
            percentageDiscountedPriceLabel.text = percentageDiscounterPrice.formatToCartPrice()
        }
        if let instantDiscountPrice = regularProduct.instantDiscountPrice {
            discountedAtCartPriceLabel.text = instantDiscountPrice.formatToCartPrice()
        }
        vendorNameLabel.text = regularProduct.sellerName
    }
    
    
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
