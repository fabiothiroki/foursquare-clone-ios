//
//  PlaceTip.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 09/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import Mapper

struct PlaceTip: Mappable {
    let text: String

    init(map: Mapper) throws {
        try text = map.from("text")
    }
}
