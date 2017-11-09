//
//  LocationPlaces.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 09/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import Mapper

struct LocationPlaces: Mappable {
    let places: [Place]
    let headerFullLocation: String

    init(map: Mapper) throws {
        let groups: [Group] = try map.from("groups")
        places = groups.first?.places ?? []

        try headerFullLocation = map.from("headerFullLocation")
    }
}
