//
//  AppReducer.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 15/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: FetchedPlacesState?) -> FetchedPlacesState {

    return state ?? FetchedPlacesState(places: .loading)
}
