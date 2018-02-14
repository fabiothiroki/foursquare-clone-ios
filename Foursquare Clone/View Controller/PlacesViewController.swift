//
//  PlacesViewController.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 13/02/18.
//  Copyright © 2018 Fabio Hiroki. All rights reserved.
//

import UIKit
import ReSwift

class PlacesViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        store.dispatch(FetchPlacesAction())
    }
}

extension PlacesViewController: StoreSubscriber {

    func newState(state: FetchedPlacesState) {
        switch state.places {
        case .loading:
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        default:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }

        print(state)
    }

}
