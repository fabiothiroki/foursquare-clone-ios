//
//  Place.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 30/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import Mapper

struct Place: Mappable {

    let name: String

    init(map: Mapper) throws {
        try name = map.from("venue.name")
    }
}
