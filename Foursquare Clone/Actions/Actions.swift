//
//  Actions.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 15/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import ReSwift

struct FetchPlacesAction: Action {}

struct SetPlacesAction: Action, Equatable {
    let places: LocationPlaces

    static func == (lhs: SetPlacesAction, rhs: SetPlacesAction) -> Bool {
        return lhs.places == rhs.places
    }
}

struct SetErrorAction: Action {
    let error: Error
}
