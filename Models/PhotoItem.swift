//
//  PhotoItem.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 08/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import Mapper

struct PhotoItem: Mappable {
    let imageUrl: String

    init(map: Mapper) throws {
        let prefix: String = try map.from("prefix")
        let suffix: String = try map.from("suffix")

        imageUrl = "\(prefix)original\(suffix)"
    }
}
