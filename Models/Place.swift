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
    let category: String
    let imageUrl: String
    let description: String

    init(map: Mapper) throws {
        try name = map.from("venue.name")

        let categories: [Category] = try map.from("venue.categories")
        category = categories.first?.name ?? ""

        let photoGroup: [PhotoGroup] = try map.from("venue.photos.groups")
        imageUrl = photoGroup.first?.items.first?.imageUrl ?? ""

        let placeTip: [PlaceTip]? = map.optionalFrom("tips")
        description = placeTip?.first?.text ?? ""
    }
}

extension Place: Equatable {
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.name == rhs.name
        && lhs.category == rhs.category
        && lhs.imageUrl == rhs.imageUrl
        && lhs.description == rhs.description
    }
}
