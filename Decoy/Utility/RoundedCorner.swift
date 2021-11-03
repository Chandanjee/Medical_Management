//
//  RoundedCorner.swift
//  SmoothTabBar
//
//  Created by Chandan Jee on 22/10/21.
//

import Foundation
import UIKit

@IBDesignable class RoundedImage: UIImageView
{
    override func layoutSubviews() {
        super.layoutSubviews()

        updateCornerRadius()
    }

    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.1 {
        didSet {
            updateCornerRadius()
        }
    }

    func updateCornerRadius() {
        layer.cornerRadius = rounded ? cornerRadius : 0
        layer.masksToBounds = rounded ? true : false
    }
}


@IBDesignable class RoundedView: UIView
{
    override func layoutSubviews() {
        super.layoutSubviews()

        updateCornerRadius()
    }

    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.1 {
        didSet {
            updateCornerRadius()
        }
    }

    func updateCornerRadius() {
        layer.cornerRadius = rounded ? cornerRadius : 0
        layer.masksToBounds = rounded ? true : false
    }
}

