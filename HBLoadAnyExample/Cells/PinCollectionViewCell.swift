//
//  PinCollectionViewCell.swift
//  HBLoadAnyExample
//
//  Created by Harshal Bhavsar on 18/03/18.
//  Copyright © 2018 Harshal Bhavsar. All rights reserved.
//

import UIKit

class PinCollectionViewCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var pinImageView: UIImageView!

    public func setImage(_ url: URL?, animated: Bool = false, completion:((_ image: UIImage?) -> Void)?){
        pinImageView.setImageFrom(url, animated: animated) { (image) in
            completion?(image)
        }
    }
}
