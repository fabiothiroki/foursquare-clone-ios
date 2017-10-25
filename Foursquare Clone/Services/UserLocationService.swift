//
//  UserLocationService.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 11/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import CoreLocation
import RxSwift

protocol LocationManager {
    var delegate: CLLocationManagerDelegate? { get set }
    func requestWhenInUseAuthorization()
    func requestLocation()
}

extension CLLocationManager: LocationManager {}

class UserLocationService: NSObject {

    fileprivate var locationManager: LocationManager
    fileprivate var lastLocation: CLLocation?

    init(locationManager: LocationManager) {

        self.locationManager = locationManager

        super.init()

        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
    }

    func getUserLastLocation(_ observer: AnyObserver<CLLocation>) {
        
//        observer.
        
    }
}

extension UserLocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.lastLocation = locations[0]
    
        
        print(locations)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
