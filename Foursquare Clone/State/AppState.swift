//
//  AppState.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 15/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import ReSwift

enum Result {
    case loading
    case failed
    case finished(LocationPlaces)
}

extension Result: Equatable {
    static func == (lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case let (.finished(a), .finished(b)):
            return a == b
        default:
            return false
        }
    }
}

struct FetchedPlacesState: StateType {
    var places: Result = .loading
}

extension FetchedPlacesState: Equatable {
    static func == (lhs: FetchedPlacesState, rhs: FetchedPlacesState) -> Bool {
        return lhs.places == rhs.places
    }
}
