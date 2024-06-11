//
//  SponsoredProductsCollectionViewCell.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import UIKit

final class SponsoredProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var discountRateLabel: UILabel!
    @IBOutlet weak var ratingView: UIStackView!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var discountedPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCellWith(sponsoredProduct: Product) {
        if let urlString = sponsoredProduct.image {
            if  let url = URL(string:urlString) {
                productImageView.kf.setImage(with: url)
            }
        }

        productTitleLabel.text = sponsoredProduct.title
        if let price = sponsoredProduct.price {
            let priceString = price.formatToCartPriceString()
            let attributeString = crateLinedStringFrom(string: priceString)
            originalPriceLabel.attributedText = attributeString
        }
        discountedPriceLabel.text = sponsoredProduct.instantDiscountPrice?.formatToCartPriceString()
        setStarsFor(rating: sponsoredProduct.rate)
        
        guard let discountRate = createDiscountRateString(price: sponsoredProduct.price, discountedPrice: sponsoredProduct.instantDiscountPrice) else { return }
        discountRateLabel.text = discountRate
    }

    override func prepareForReuse() {
        productImageView.kf.cancelDownloadTask()
    }
    
    private func setStarsFor(rating: Double?){
        guard let rating = rating else { return }
        guard rating < 6 else  { return }
        guard rating >= 0 else { return }
        
        let ratinInt = Int(rating)
        
        guard let views = ratingView.arrangedSubviews as? [UIImageView] else { return }
        for i in 1...ratinInt {
            let view = views[(i-1)]
            view.image = UIImage(systemName: "star.fill")
            view.tintColor = .systemYellow
        }
    }
}
