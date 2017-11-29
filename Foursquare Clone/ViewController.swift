//
//  ViewController.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 08/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import UIKit
import CoreLocation
import RxSwift
import ReSwift

class ViewController: UIViewController, StoreSubscriber {

    var store: Store<FetchedPlacesState>?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store?.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store?.unsubscribe(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        store?.dispatch(FetchPlacesAction())
    }

    func newState(state: FetchedPlacesState) {
        print(state)
    }
}
