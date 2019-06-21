//
//  UIViewExtension.swift
//
//  Created by Pramod Kumar on 5/17/17.
//  Copyright © 2017 Pramod Kumar. All rights reserved.
//

import Foundation
import UIKit

// MARK: -  UIView

extension UIView {
    public var autoResizingActive: Bool {
        get {
            return self.translatesAutoresizingMaskIntoConstraints
        }
        set {
            self.translatesAutoresizingMaskIntoConstraints = autoResizingActive
            for view in self.subviews {
                view.autoResizingActive = autoResizingActive
            }
        }
    }
    
    public var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.width, height: self.height)
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.width, height: self.height)
        }
    }
    
    public var width: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.height)
        }
    }
    
    public var height: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.width, height: value)
        }
    }
    
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }
    
    public var right: CGFloat {
        get {
            return self.x + self.width
        } set(value) {
            self.x = value - self.width
        }
    }
    
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }
    
    public var bottom: CGFloat {
        get {
            return self.y + self.height
        } set(value) {
            self.y = value - self.height
        }
    }
    
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }
    
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }
    
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }
    
    public var size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame = CGRect(origin: self.frame.origin, size: value)
        }
    }
    
    // MARK: - set round corners
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    // MARK: - set round corners by clips to bounds
    
    func roundTopCorners(cornerRadius: CGFloat) {
        self.clipsToBounds = true
        self.addShadow(cornerRadius: cornerRadius, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], color: .clear, offset: .zero, opacity: 0.0, shadowRadius: 0.0)
    }
    
    func roundBottomCorners(cornerRadius: CGFloat) {
        self.clipsToBounds = true
        self.addShadow(cornerRadius: cornerRadius, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], color: .clear, offset: .zero, opacity: 0.0, shadowRadius: 0.0)
    }
    
    func addShadow(cornerRadius: CGFloat, maskedCorners: CACornerMask, color: UIColor, offset: CGSize, opacity: Float, shadowRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = maskedCorners
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
    }
    
    /// SHOW VIEW
    func showViewWithFade() {
        self.alpha = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
        }, completion: { (_: Bool) -> Void in
            self.alpha = 1.0
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.layer.add(transition, forKey: nil)
            self.isHidden = false
        })
    }
    
    /// HIDE VIEW
    func hideViewWithFade() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1.0
        }, completion: { (_: Bool) -> Void in
            self.alpha = 0.0
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.layer.add(transition, forKey: nil)
            self.isHidden = true
        })
    }
    
    public func addGrayShadow(ofColor color: UIColor = UIColor.black, radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.2, cornerRadius: CGFloat? = nil) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
        if let r = cornerRadius {
            layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: r).cgPath
        }
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func addNoDataLable(_ withDataCount: Int, withMessage: String = "No Data Found", withFont: UIFont = UIFont.systemFont(ofSize: 18.0), textColor: UIColor = UIColor.lightGray) {
        self.removeNoDataLabel()
        
        if withDataCount <= 0 {
            let msgLabel = UILabel()
            msgLabel.frame = self.bounds
            msgLabel.text = withMessage.isEmpty ? "No Data Found" : withMessage
            msgLabel.textAlignment = NSTextAlignment.center
            msgLabel.tag = 862548
            msgLabel.font = withFont
            msgLabel.textColor = textColor
            msgLabel.numberOfLines = 0
            msgLabel.backgroundColor = UIColor.clear
            msgLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            self.addSubview(msgLabel)
            self.bringSubviewToFront(msgLabel)
        }
    }
    
    fileprivate func removeNoDataLabel() {
        if let msgLabel = self.viewWithTag(862548) {
            msgLabel.removeFromSuperview()
        }
    }
    
    // method to make a view circular
    func makeCircular(borderWidth: CGFloat = 0.0, borderColor: UIColor = .clear) {
        self.cropCorner(radius: self.frame.size.height / 2.0, borderWidth: borderWidth, borderColor: borderColor)
    }
    
    // method to give corner a view
    func cropCorner(radius: CGFloat, borderWidth: CGFloat = 0.0, borderColor: UIColor = .clear) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = true
    }
    
    func drawDottedLine(color: UIColor = .lightGray, start p0: CGPoint, end p1: CGPoint) {
        _ = self.layer.sublayers?.filter({ $0.name == "DashedTopLine" }).map({ $0.removeFromSuperlayer() })
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "DashedTopLine"
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [3, 2] // 3 is the length of dash, 2 is length of the gap.
        
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    
    func rotate(rotationAngle: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: rotationAngle)
        self.clipsToBounds = true
    }
    
    var collectionViewCell: UICollectionViewCell? {
        var subviewClass = self
        
        while !(subviewClass is UICollectionViewCell) {
            guard let view = subviewClass.superview else { return nil }
            
            subviewClass = view
        }
        
        return subviewClass as? UICollectionViewCell
    }
    
    func showBlurLoader(frame:CGRect) {
//        let blurLoader = BlurLoader(frame: frame)
//        self.addSubview(blurLoader)
    }
    
    func removeBluerLoader() {
//        if let blurLoader = subviews.first(where: { $0 is BlurLoader }) {
//            blurLoader.removeFromSuperview()
//        }
    }
    
    func collectionViewIndexPath(_ collectionView: UICollectionView) -> IndexPath? {
        if let cell = self.collectionViewCell {
            return collectionView.indexPath(for: cell)
        }
        return nil
    }
    
    func rootSuperView() -> UIView? {
        var view = self
        while let parentView = view.superview {
            view = parentView
        }
        return view
    }
}

extension UIView {
    func addshadowOnSelectedEdge(top: Bool,
                                 left: Bool,
                                 bottom: Bool,
                                 right: Bool,
                                 opacity: Float,
                                 shadowRadius: CGFloat = 2.0,
                                 offset:CGSize = CGSize.zero,
                                 color: UIColor = .lightGray) {
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        
        let path = UIBezierPath()
        var x: CGFloat = 0
        var y: CGFloat = 0
        var viewWidth = self.frame.width
        var viewHeight = self.frame.height
        
        // here x, y, viewWidth, and viewHeight can be changed }}
        // order to play around with the shadow paths.
        if (!top) {
            y+=(shadowRadius+1)
        }
        if (!bottom) {
            viewHeight-=(shadowRadius+1)
        }
        if (!left) {
            x+=(shadowRadius+1)
        }
        if (!right) {
            viewWidth-=(shadowRadius+1)
        }
        // selecting top most point
        path.move(to: CGPoint(x: x, y: y))
        // Move to the Bottom Left Corner, this will cover left edges
        /*
         |☐
         */
        path.addLine(to: CGPoint(x: x, y: viewHeight))
        // Move to the Bottom Right Corner, this will cover bottom edge
        /*
         ☐
         -
         */
        path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
        // Move to the Top Right Corner, this will cover right edge
        /*
         ☐|
         */
        path.addLine(to: CGPoint(x: viewWidth, y: y))
        // Move back to the initial point, this will cover the top edge
        /*
         _
         ☐
         */
        path.close()
        self.layer.shadowPath = path.cgPath
    }
}
