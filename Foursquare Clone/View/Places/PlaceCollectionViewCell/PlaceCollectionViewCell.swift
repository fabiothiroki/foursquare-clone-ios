//
//  PlaceCollectionViewCell.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 14/02/18.
//  Copyright © 2018 Fabio Hiroki. All rights reserved.
//

import UIKit

class PlaceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var place: Place? {
        didSet {
            guard let place = place else { return }
            let name = place.name

//            hero.id = "\(name)"

            nameLabel.text = name
//            imageView.image = place.image
//            descriptionLabel.text = place.description
        }
    }
}
