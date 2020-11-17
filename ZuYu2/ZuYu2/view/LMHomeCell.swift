//
//  LMHomeCell.swift
//  ZuYu2
//
//  Created by million on 2020/8/20.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class LMHomeCell: UICollectionViewCell {
    
    @IBOutlet weak var mImageView: UIImageView!
    
    @IBOutlet weak var mTitleLabel: UILabel!
    
    var model : [String : String]? {
        didSet {
            let imgName = model?["icon"]
            let text = model?["desc"]
            mImageView.image = UIImage.init(named: imgName ?? "")
            mTitleLabel.text = text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size = size
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}
