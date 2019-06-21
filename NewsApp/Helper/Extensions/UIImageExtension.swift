//
//  UIImageExtension.swift
//
//  Created by Pramod Kumar on 04/04/18.
//  Copyright © 2018 Pramod Kumar. All rights reserved.
//

import Foundation
import UIKit

//MARK:- UIImage Extension
extension UIImage {
    
    class func blurEffect(_ cgImage: CGImage) -> UIImage! {
        return UIImage(cgImage: cgImage)
    }
    
    func blurEffect(_ boxSize: Float) -> UIImage! {
        return UIImage(cgImage: blurredCGImage(boxSize))
    }
    
    func blurredCGImage(_ boxSize: Float) -> CGImage! {
        return cgImage!.blurEffect(boxSize)
    }
    
    func resizeImage(_ newSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func blurredImage(_ boxSize: Float, times: UInt = 1) -> UIImage {
        var image = self
        for _ in 0..<times {
            image = image.blurEffect(boxSize)
        }
        return image
    }
    
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch self.imageOrientation {
        case .up,.downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
            
        case .left,.leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
            
        case .right,.rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: CGFloat(-(Double.pi / 2)))
        default: break
        }
        
        switch self.imageOrientation {
            
        case .upMirrored,.downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        case .leftMirrored,.rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        default: break
            
        }
        
        let ctx: CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)!
        
        ctx.concatenate(transform)
        
        switch self.imageOrientation {
            
        case .left,.leftMirrored,.right,.rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
            
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        }
        
        let cgimg: CGImage = ctx.makeImage()!
        let img: UIImage = UIImage(cgImage: cgimg)
        return img
    }
    
    convenience init?(text: String, font: UIFont = UIFont.systemFont(ofSize: 20), color: UIColor = .lightGray, backgroundColor: UIColor = .white, size:CGSize = CGSize(width: 100, height: 100), offset: CGPoint = CGPoint(x: 0, y: 0))
    {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backgroundColor.cgColor)
        context?.fill(CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attr = [NSAttributedString.Key.font:font, NSAttributedString.Key.foregroundColor:color, NSAttributedString.Key.paragraphStyle:style]
        let rect = CGRect(x: offset.x, y: offset.y, width: size.width, height: size.height)
        text.draw(in: rect, withAttributes: attr)
        self.init(cgImage:(UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
    }
    
}

extension UIImageView {
    
    func setImageWithUrl(_ imageUrl: String, placeholder: UIImage, showIndicator:Bool) {
        var imageUrl = imageUrl
        guard imageUrl.count > 0 else {
            self.image = placeholder
            return
        }
        
        func setImage(url: URL, showIndicator:Bool) {
//            if showIndicator{
//                self.kf.indicatorType = .activity
//            }
//            self.kf.setImage(with: url, placeholder: placeholder)
        }
        
        self.image = placeholder
        if imageUrl.hasPrefix("//") {
            imageUrl = "https:" + imageUrl
        }
        if imageUrl.hasPrefix("http://") || imageUrl.hasPrefix("https://"), let url = URL(string: imageUrl){
            setImage(url: url, showIndicator:showIndicator)
        }
        else {
            setImage(url: URL(fileURLWithPath: imageUrl), showIndicator:showIndicator)
        }
    }
    
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
        
    
}


extension UIImage {
    
    var blur: UIImage {
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: self)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(9, forKey: kCIInputRadiusKey)
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
        
        let context = CIContext(options: nil)
        let output = cropFilter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        return UIImage(cgImage: cgimg!)
    }
}

extension UIImageView {
    func applyGaussianBlurEffect(image: UIImage){
        let imageToBlur = CIImage(image: image)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter?.setValue(imageToBlur, forKey: "inputImage")
        if let resultImage = blurfilter?.value(forKey: "outputImage") as? CIImage {
            self.image = UIImage(ciImage: resultImage)
        }
    }
}
