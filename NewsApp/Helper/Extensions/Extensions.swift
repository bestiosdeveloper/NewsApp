//
//  Extensions.swift
//
//  Created by Pramod Kumar on 5/23/17.
//  Copyright © 2017 Pramod Kumar. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import AVKit
import Accelerate


extension CGPoint {
    
    var avoidNaN:CGPoint{
        
        var point = self
        if point.x.isNaN{
            point.x = 0
        }
        if point.y.isNaN{
            point.y = 0
        }
        return point
    }
}

extension CGSize {
    
    var avoidNaN:CGSize{
        
        var size = self
        if size.width.isNaN{
            size.width = 0
        }
        if size.height.isNaN{
            size.height = 0
        }
        return size
    }
}

extension UIEdgeInsets {
    
    var avoidNaN:UIEdgeInsets{
        
        var insets = self
        if insets.top.isNaN{
            insets.top = 0
        }
        if insets.left.isNaN{
            insets.left = 0
        }
        if insets.bottom.isNaN{
            insets.bottom = 0
        }
        if insets.right.isNaN{
            insets.right = 0
        }
        return insets
    }
}

extension CGRect{
    
    subscript(multiplier: CGFloat) -> CGRect {
        
        var rect = self
        rect.origin.x *= multiplier
        rect.origin.y *= multiplier
        rect.size.width *= multiplier
        rect.size.height *= multiplier
        return rect
    }
    
    var avoidNaN:CGRect{
        
        var rect = self
        rect.origin = rect.origin.avoidNaN
        rect.size = rect.size.avoidNaN
        return rect
    }
}
extension UITextView{
    
    func alignTextCenterVerticaly(){
        
        let deadSpace = self.bounds.size.height - self.contentSize.height
        let inset = max(0, deadSpace/2.0)
        self.contentInset = UIEdgeInsets(top: inset, left: self.contentInset.left, bottom: inset, right: self.contentInset.right)
        setContentOffsetCenterVerticaly()
    }
    func setContentOffsetCenterVerticaly(){

        if (self.height < self.contentSize.height) {
            var contentOffset = self.contentOffset
            contentOffset.y = (self.contentSize.height - self.height) * 0.5
            self.contentOffset = contentOffset
        }
    }
}

extension Int{
    
    var toBool:Bool{
        return self == 0 ? false:true
    }
    var toString:String{
        return "\(self)"
    }
    var toInt32:Int32{
        return Int32(self)
    }
    var toInt64:Int64{
        return Int64(self)
    }
    var toFloat:Float{
        return Float(self)
    }
    var toFloat32:Float32{
        return Float32(self)
    }
    var toFloat64:Float64{
        return Float64(self)
    }
    var toCGFloat:CGFloat{
        return CGFloat(self)
    }
    var toDouble:Double{
        return Double(self)
    }
    var unitFormattedString: String{
        return self.toString.unitFormattedString
    }
}

extension Int32{
    
    var toBool:Bool{
        return self == 0 ? false:true
    }
    var toString:String{
        return "\(self)"
    }
    var toInt:Int{
        return Int(self)
    }
    var toInt64:Int64{
        return Int64(self)
    }
    var toFloat:Float{
        return Float(self)
    }
    var toFloat32:Float32{
        return Float32(self)
    }
    var toFloat64:Float64{
        return Float64(self)
    }
    var toCGFloat:CGFloat{
        return CGFloat(self)
    }
    var toDouble:Double{
        return Double(self)
    }
    var unitFormattedString: String{
        return self.toString.unitFormattedString
    }
}

extension Int64{
    
    var toBool:Bool{
        return self == 0 ? false:true
    }
    var toString:String{
        return "\(self)"
    }
    var toInt:Int{
        return Int(self)
    }
    var toInt64:Int64{
        return Int64(self)
    }
    var toFloat:Float{
        return Float(self)
    }
    var toFloat32:Float32{
        return Float32(self)
    }
    var toFloat64:Float64{
        return Float64(self)
    }
    var toCGFloat:CGFloat{
        return CGFloat(self)
    }
    var toDouble:Double{
        return Double(self)
    }
    var unitFormattedString: String{
        return self.toString.unitFormattedString
    }
}

extension Float{
    
    var toBool:Bool{
        return self == 0 ? false:true
    }
    var toString:String{
        return "\(self)"
    }
    var toInt:Int{
        return Int(self)
    }
    var toInt32:Int32{
        return Int32(self)
    }
    var toInt64:Int64{
        return Int64(self)
    }
    var toFloat32:Float32{
        return Float32(self)
    }
    var toFloat64:Float64{
        return Float64(self)
    }
    var toCGFloat:CGFloat{
        return CGFloat(self)
    }
    var toDouble:Double{
        return Double(self)
    }
    var unitFormattedString: String{
        return self.toString.unitFormattedString
    }
    func roundTo(places: Int) -> Float {
        return Float(Double(self).roundTo(places: places))
    }
}


extension Double{
    
    var toBool:Bool{
        return self == 0 ? false:true
    }
    var toString:String{
        return "\(self)"
    }
    var toInt:Int{
        return Int(self)
    }
    var toInt32:Int32{
        return Int32(self)
    }
    var toInt64:Int64{
        return Int64(self)
    }
    var toFloat:Float{
        return Float(self)
    }
    var toFloat32:Float32{
        return Float32(self)
    }
    var toFloat64:Float64{
        return Float64(self)
    }
    var toCGFloat:CGFloat{
        return CGFloat(self)
    }
    var unitFormattedString: String{
        return self.toString.unitFormattedString
    }
    
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    private static var currencyFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "en_IN")
        
        return numberFormatter
    }()
    
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "en_IN")
        
        return numberFormatter
    }()
    
    var delimiterWithSymbolTill2Places: String {
        return Double.currencyFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    var delimiterWithSymbol: String {
        return Double.currencyFormatter.string(from: NSNumber(value: Int(self))) ?? ""
    }
    
    var delimiterWithoutSymbol: String {
        return Double.numberFormatter.string(from: NSNumber(value: Int(self))) ?? ""
    }
}

extension CGFloat{
    
    var toBool:Bool{
        return self == 0 ? false:true
    }
    var toString:String{
        return "\(self)"
    }
    var toInt:Int{
        return Int(self)
    }
    var toInt32:Int32{
        return Int32(self)
    }
    var toInt64:Int64{
        return Int64(self)
    }
    var toFloat:Float{
        return Float(self)
    }
    var toFloat32:Float32{
        return Float32(self)
    }
    var toFloat64:Float64{
        return Float64(self)
    }
    var toDouble:Double{
        return Double(self)
    }
    var unitFormattedString: String{
        return self.toString.unitFormattedString
    }
    func roundTo(places: Int) -> CGFloat {
        return CGFloat(Double(self).roundTo(places: places))
    }
}
extension Bool{
    var toInt:Int{
        return self == true ? 1:0
    }
    var toInt32:Int32{
        return self == true ? 1:0
    }
    var toInt64:Int64{
        return self == true ? 1:0
    }
    var toFloat:Float{
        return self == true ? 1:0
    }
    var toFloat32:Float32{
        return self == true ? 1:0
    }
    var toFloat64:Float64{
        return self == true ? 1:0
    }
    var toDouble:Double{
        return self == true ? 1:0
    }
}
extension UICollectionViewCell{
    
    class var nibName : String {
        return "\(self)"
    }
}

extension UITableViewCell{
    
    class var nibName : String {
        return "\(self)"
    }
}

extension Data{
    
    var toJSON:Any?{
        
        do {
            let parseJSON = try JSONSerialization.jsonObject(with: self, options: .allowFragments)
            return parseJSON
            
        } catch let error as NSError {
            printDebug("Failed to load: \(error.localizedDescription)")
            return nil
        }
    }
}
//MARK:- Bool Extension
extension Bool{
    var intValue: Int {
        return self ? 1 : 0
    }
}
//MARK:- AVAsset Extension
extension AVAsset {
    
    var fileSizeInMB: CGFloat {
        var estimatedSize: CGFloat = 0.0
        
        for newTrack in self.tracks {
            let rate = newTrack.estimatedDataRate / 8
            let seconds = CMTimeGetSeconds(newTrack.timeRange.duration)
            estimatedSize += CGFloat(seconds) * CGFloat(rate)
        }
        
        return (estimatedSize / 1024.0) / 1024.0
    }
}

//MARK:- UITextField Extension
extension UITextField {
    
    func placeholder(text: String, withColor color: UIColor){
        let str = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:color])
        self.attributedPlaceholder = str
    }
    
}
//MARK:- UIBottun Extension
extension UIButton {
    func enableAutushrink() {
        self.titleLabel?.numberOfLines = 1
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
    }
}
//MARK:- CGImage Extension
extension CGImage {
    
    func blurEffect(_ boxSize: Float) -> CGImage! {
        
        let boxSize = boxSize - (boxSize.truncatingRemainder(dividingBy: 2)) + 1
        let inProvider = self.dataProvider
        let height = vImagePixelCount(self.height)
        let width = vImagePixelCount(self.width)
        let rowBytes = self.bytesPerRow
        
        let inBitmapData = inProvider!.data
        let inData = UnsafeMutableRawPointer(mutating: CFDataGetBytePtr(inBitmapData))
        var inBuffer = vImage_Buffer(data: inData, height: height, width: width, rowBytes: rowBytes)
        
        let outData = malloc(self.bytesPerRow * self.height)
        var outBuffer = vImage_Buffer(data: outData, height: height, width: width, rowBytes: rowBytes)
        _ = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: outBuffer.data, width: Int(outBuffer.width), height: Int(outBuffer.height), bitsPerComponent: 8, bytesPerRow: outBuffer.rowBytes, space: colorSpace, bitmapInfo: self.bitmapInfo.rawValue)!
        let imageRef = context.makeImage()
        
        free(outData)
        
        return imageRef
    }
}
//MARK:- CGFloat Extension
extension CGFloat {
    
    var roundedValue: CGFloat {
        let value = CGFloat(Int(self))
        let diff = self - value
        return diff < 0.5 ? value : value + 1
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var kFormatted: String {
        var num: Double = self
        let sign = ((num < 0) ? "-" : "" )
        
        num = fabs(num)
        
        if (num < 1000.0){
            return "\(sign)\(Int(num))";
        }
        
        let exp:Int = Int(log10(num) / 3.0 )
        
        let units:[String] = ["K","M","G","T","P","E"]
        
        let roundedNum:Double = Darwin.round(Double(10 * num / pow(1000.0,Double(exp)))) / 10
        
        return "\(sign)\(Int(roundedNum))\(units[exp-1])"
    }
}


extension UIView{
    
    var replaceFontsWithHelvetica:Void{
        
        //        let subViews = self.subviews
        //
        //        if subViews.count == 0{
        //            if let tempView = self as? UILabel{
        //                tempView.font = tempView.font.helvetica
        //            }
        //            else if let tempView = self as? UITextField{
        //                tempView.font = tempView.font?.helvetica
        //            }
        //            else if let tempView = self as? UITextView{
        //                tempView.font = tempView.font?.helvetica
        //            }
        //            else if let tempView = self as? UIButton{
        //                tempView.titleLabel?.font = tempView.titleLabel?.font.helvetica
        //            }
        //            return
        //        }
        //        for view in subViews{
        //            view.replaceFontsWithHelvetica
        //        }
        return
    }
}
//extension UIImageView {
//
//    func setSVGImageWithURL(url:URL, placeholder:UIImage? = nil, completion:((UIImage?)->Void)? = nil){
//
//
//        let cacheDict = ["name":url.absoluteString]
//
//        if let image = SVGImageCache.shared().cachedImage(withKey: cacheDict) {
//            if let compltion = completion{
//                compltion(image)
//            }
//            else{
//                self.image = image
//            }
//        }
//        else{
//
//            self.image = placeholder
//            let session = URLSession.shared
//            let dataTask = session.dataTask(with: url) {[weak self] (data, response, error) in
//
//                if error == nil, data != nil, self != nil{
//
//                    Global.getMainQueue {[weak self] in
//
//                        if let img = SVGKImage(data:data)?.uiImage{
//
//                            if let compltion = completion{
//                                compltion(img)
//                            }
//                            else{
//                                self?.image = img
//                            }
//                            SVGImageCache.shared().addImage(toCache: img, forKey: cacheDict)
//                        }
//                        else{
//                            if let compltion = completion{
//                                compltion(nil)
//                            }
//                            else{
//                                self?.image = placeholder
//                            }
//                        }
//                    }
//                }
//                else{
//                    completion?(nil)
//                }
//            }
//            dataTask.resume()
//        }
//    }
//}

//extension UIFont{
//
//    var helvetica:UIFont?{
//
//        let fontSize = self.pointSize
//        //                printDebug("fontName---->>>>>>>>> \(self.fontName)")
//        //        for name in UIFont.familyNames{
//        //            printDebug("fontName---->>>>>>>>> \(UIFont.fontNames(forFamilyName: name))")
//        //
//        //        }
//        if !self.fontName.lowercased().contains("helvetica"){
//
//            if self.fontName.lowercased().contains("regular"){
//                return UIFont(name: FontName.HelveticaNeue.regular, size: fontSize)
//            }
//            else if self.fontName.lowercased().contains("semibold"){
//                return UIFont(name: FontName.HelveticaNeue.bold, size: fontSize)
//            }
//            else if self.fontName.lowercased().contains("thinitalic"){
//                return UIFont(name: FontName.HelveticaNeue.thinItalic, size: fontSize)
//            }
//            else if self.fontName.lowercased().contains("lightitalic"){
//                return UIFont(name: FontName.HelveticaNeue.lightItalic, size: fontSize)
//            }
//            else if self.fontName.lowercased().contains("bolditalic"){
//                return UIFont(name: FontName.HelveticaNeue.boldItalic, size: fontSize)
//            }
//            else if self.fontName.lowercased().contains("mediumitalic"){
//                return UIFont(name: FontName.HelveticaNeue.mediumItalic, size: fontSize)
//            }
//            else if self.fontName.lowercased().contains("italic"){
//                return UIFont(name: FontName.HelveticaNeue.italic, size: fontSize)
//            }
//            else if self.fontName.lowercased().contains("thin"){
//                return UIFont(name: FontName.HelveticaNeue.thin, size: fontSize)
//            }
//            else if self.fontName.lowercased().contains("light"){
//                return UIFont(name: FontName.HelveticaNeue.light, size: fontSize)
//            }
//            else if self.fontName.lowercased().contains("bold"){
//                return UIFont(name: FontName.HelveticaNeue.bold, size: fontSize)
//            }
//            else if self.fontName.lowercased().contains("medium"){
//                return UIFont(name: FontName.HelveticaNeue.medium, size: fontSize)
//            }
//            else if self.fontName.lowercased().contains("heavy"){
//                return UIFont(name: FontName.HelveticaNeue.bold, size: fontSize)
//            }
//            else if self.fontName.components(separatedBy: " ").joined(separator: "").lowercased() == self.familyName.components(separatedBy: " ").joined(separator: "").lowercased(){
//                return UIFont(name: FontName.HelveticaNeue.regular, size: fontSize)
//            }
//        }
//        return self
//    }
//}

//extension UITextField {
//    
//    func setImageToRightView(img : UIImage, size: CGSize?) {
//        
//        self.rightViewMode = .always
//        
//        let rightImage = UIImageView(image: img)
//        self.rightView = rightImage
//        
//        rightImage.contentMode = UIViewContentMode.center
//        if let imgSize = size {
//            self.rightView?.frame.size = imgSize
//        } else {
//            self.rightView?.frame.size = CGSize(width: 50, height: self.frame.height)
//        }
//        self.rightView?.contentMode = .center
//        rightImage.frame = self.rightView!.frame
//    }
//}


extension NSLayoutConstraint {
    
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem!,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = shouldBeArchived
        newConstraint.identifier = identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
