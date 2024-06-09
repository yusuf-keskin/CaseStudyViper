//
//  ProductDetailsVCViewController.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 9.06.2024.
//

import UIKit

class ProductDetailsVCViewController: UIViewController {
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
        // Do any additional setup after loading the view.
    }
    
    private func setCollectionView() {
        imagesCollectionView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesCollectionViewCell")
    }
    
    
    @IBAction func buyNowButton(_ sender: Any) {
    }
    

    @IBAction func addToChartButton(_ sender: Any) {
    }
}

extension ProductDetailsVCViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
        return cell
    }
    
}

extension ProductDetailsVCViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        return CGSize(width: width, height: height)
    }
}
