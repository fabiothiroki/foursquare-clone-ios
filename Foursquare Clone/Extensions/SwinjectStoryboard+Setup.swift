//
//  SwinjectStoryboard+Setup.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 25/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import CoreLocation

extension SwinjectStoryboard {
    class func setup() {
        defaultContainer.storyboardInitCompleted(ViewController.self) { resolver, container in
        }
    }

}
