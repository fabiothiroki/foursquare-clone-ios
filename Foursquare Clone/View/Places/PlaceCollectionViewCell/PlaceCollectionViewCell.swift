//
//  PlaceCollectionViewCell.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 14/02/18.
//  Copyright © 2018 Fabio Hiroki. All rights reserved.
//

import UIKit
import Kingfisher

class PlaceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var place: Place? {
        didSet {
            guard let place = place else { return }

            nameLabel.text = place.name

            if let url = URL(string: place.imageUrl) {
                imageView.kf.setImage(with: url)
            } else {
                imageView.image = nil
            }
            descriptionLabel.text = place.category
        }
    }
}
