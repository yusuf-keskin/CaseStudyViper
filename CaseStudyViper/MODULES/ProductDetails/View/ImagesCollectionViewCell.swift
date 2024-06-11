//
//  ImagesCollectionViewCell.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 9.06.2024.
//

import UIKit

final class ImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImageFrom(url: URL){
        imageView.kf.setImage(with: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
    }

}
