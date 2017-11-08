//
//  Category.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 08/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import Mapper

struct Category: Mappable {
    let name: String
    
    init(map: Mapper) throws {
        try name = map.from("name")
    }
}
