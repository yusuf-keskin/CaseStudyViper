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
    
    
    @MainActor
    func setupCell(regularProduct:Product){
        let url = URL(string: regularProduct.image)
        productImageView.kf.setImage(with: url)
        productTitleLabel.text = regularProduct.title
        setStarsFor(rating: regularProduct.rate)
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(regularProduct.price)")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        defaultPriceLabel.attributedText = attributeString
        let percentageDiscounterPrice = Double(round(100 * (regularProduct.price * 0.96)) / 100)
        percentageDiscountedPriceLabel.text = percentageDiscounterPrice.formatToCartPrice()
        if let instantDiscountPrice = regularProduct.instantDiscountPrice {
            discountedAtCartPriceLabel.text = instantDiscountPrice.formatToCartPrice()
        }
        vendorNameLabel.text = regularProduct.sellerName
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
