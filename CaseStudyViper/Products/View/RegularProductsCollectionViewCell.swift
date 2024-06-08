//
//  CollectionViewCell.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 8.06.2024.
//

import UIKit

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
        
    }
    
    
    private func setStarsFor(rating: Int){
        guard let views = ratingView.arrangedSubviews as? [UIImageView] else { return }
        for i in 1...rating {
            let view = views[(i-1)]
            view.image = UIImage(systemName: "star.fill")
            view.tintColor = .orange
        }
    }

}
