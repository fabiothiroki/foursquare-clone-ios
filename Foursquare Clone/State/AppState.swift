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

extension Result: Equatable {
    static func == (lhs: Result<T>, rhs: Result<T>) -> Bool {
        switch (lhs, rhs) {
        case (Result<T>.loading, Result<T>.loading):
            return true
        default:
            return false
        }
    }
}

struct FetchedPlacesState: StateType {
    var places: Result<LocationPlaces> = .loading
}

extension FetchedPlacesState: Equatable {
    static func == (lhs: FetchedPlacesState, rhs: FetchedPlacesState) -> Bool {
        return lhs.places == rhs.places
    }
}
