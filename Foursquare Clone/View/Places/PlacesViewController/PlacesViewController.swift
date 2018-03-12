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

    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    var places: [Place] = []

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

        collectionView.register(UINib(nibName: "PlaceCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "item")
    }
}

extension PlacesViewController: StoreSubscriber {

    func newState(state: FetchedPlacesState) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        locationName.isHidden = true

        switch state.places {
        case .loading:
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        case .finished(let places):
            locationName.text = "\(places.headerFullLocation)"
            locationName.isHidden = false
            self.places = places.places
            collectionView.reloadData()
        default:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }

        print(state)
    }
}

extension PlacesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "item",
                                                       for: indexPath) as? PlaceCollectionViewCell)!
        cell.place = places[indexPath.item]
        return cell
    }
}
