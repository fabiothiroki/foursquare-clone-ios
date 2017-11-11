//
//  Group.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 31/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import Mapper

struct Group: Mappable {
    let places: [Place]

    init(map: Mapper) throws {
        try places = map.from("items")
    }
}
