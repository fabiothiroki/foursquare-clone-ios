//
//  Actions.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 15/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import ReSwift

struct FetchPlacesAction: Action {}

struct SetPlacesAction: Action {
    let places: LocationPlaces
}
