//
//  UIView+FoursquareClone.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 26/02/18.
//  Copyright © 2018 Fabio Hiroki. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }

        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }

        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }

        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable public var shadowColor: UIColor? {
        get {
            return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil
        }

        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }

        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable public var zPosition: CGFloat {
        get {
            return layer.zPosition
        }

        set {
            layer.zPosition = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
        }

        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }

        set {
            layer.borderWidth = newValue
        }
    }
}
