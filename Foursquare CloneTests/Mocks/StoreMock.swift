//
//  StoreMock.swift
//  Foursquare CloneTests
//
//  Created by Fabio Hiroki on 19/12/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import ReSwift

class StoreMock: AppStore {

    var dispatchedAction: Action?

    func dispatch(_ action: Action) {
        dispatchedAction = action
    }
}
