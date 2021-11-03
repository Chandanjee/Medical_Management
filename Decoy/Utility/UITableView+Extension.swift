//
//  UITableView+Extension.swift
//  Decoy
//
//  Created by MAC on 24/10/21.
//

import Foundation
import UIKit


extension UITableView
{
    func register(_ nibs: [String])
    {
        for nib in nibs{
            self.register(UINib.init(nibName: nib, bundle: nil), forCellReuseIdentifier: nib)
        }
    }
    
    func registerHeader(_ nibs: [String])
    {
        for nib in nibs{
            self.register(UINib.init(nibName: nib, bundle: nil), forHeaderFooterViewReuseIdentifier: nib)
        }
    }
}

extension UICollectionView
{
    func registerCollection(_ nibs: [String])
    {
        for nib in nibs{
            self.register(UINib.init(nibName: nib, bundle: nil), forCellWithReuseIdentifier: nib)
        }
    }
    
    func registerHeaderCollection(_ nibs: [String])
    {
        for nib in nibs{
            self.register(UINib.init(nibName: nib, bundle: nil), forCellWithReuseIdentifier: nib)
        }
    }
}



extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
    
    func addShadow(backgroundColor: UIColor = .white, cornerRadius: CGFloat = 12, shadowRadius: CGFloat = 5, shadowOpacity: Float = 0.1, shadowPathInset: (dx: CGFloat, dy: CGFloat), shadowPathOffset: (dx: CGFloat, dy: CGFloat)) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = UIBezierPath(roundedRect: bounds.insetBy(dx: shadowPathInset.dx, dy: shadowPathInset.dy).offsetBy(dx: shadowPathOffset.dx, dy: shadowPathOffset.dy), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        let whiteBackgroundView = UIView()
        whiteBackgroundView.backgroundColor = backgroundColor
        whiteBackgroundView.layer.cornerRadius = cornerRadius
        whiteBackgroundView.layer.masksToBounds = true
        whiteBackgroundView.clipsToBounds = false
        
        whiteBackgroundView.frame = bounds.insetBy(dx: shadowPathInset.dx, dy: shadowPathInset.dy)
//        insertSubview(whiteBackgroundView, at: 0)
        self.contentView.addSubview(whiteBackgroundView)
        self.contentView.sendSubviewToBack(whiteBackgroundView)
    }
}



