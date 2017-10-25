//
//  ViewController.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 08/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let locationService = UserLocationService.init(locationManager: CLLocationManager())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

