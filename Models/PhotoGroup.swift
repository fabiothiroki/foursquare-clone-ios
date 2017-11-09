//
//  PhotoGroup.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 08/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import Mapper

struct PhotoGroup: Mappable {
    let items: [PhotoItem]

    init(map: Mapper) throws {
        items = try map.from("items")
    }
}
