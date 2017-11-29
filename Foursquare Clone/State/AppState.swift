//
//  AppState.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 15/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import ReSwift

enum Result<T> {
    case loading
    case failed
    case finished(T)
}

struct FetchedPlacesState: StateType {
    var places: Result<LocationPlaces> = .loading
}
