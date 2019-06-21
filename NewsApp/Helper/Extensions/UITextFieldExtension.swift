//
//  UITextFieldExtension.swift
//
//  Created by Pramod Kumar on 15/03/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import UIKit

extension UITextField {
    
    ///Attributed text for textfield placeholder
    func setAttributedPlaceHolder(placeHolderText: String, color: UIColor = .lightGray, font: UIFont = UIFont.systemFont(ofSize: 16.0)) {
        self.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: color,NSAttributedString.Key.font: font])
    }
    
    ///Right View Button in textfield
    func modifyClearButton(with image : UIImage, size: CGSize) {
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(image, for: .normal)
        rightButton.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        rightButton.contentMode = .scaleAspectFit
        rightButton.addTarget(self, action: #selector(self.rightButtonAction(_:)), for: .touchUpInside)
        rightView = rightButton
        rightViewMode = .whileEditing
    }
    
    @objc private func rightButtonAction(_ sender : AnyObject) {
        self.text = ""
        sendActions(for: .editingChanged)
    }
    
    ///Text field clear button setUp
    func textFieldClearBtnSetUp() {
        if let clearButton : UIButton = self.value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(#imageLiteral(resourceName: "ic_toast_cross"), for: .normal)
            clearButton.size = CGSize(width: 16.0, height: 16.0)
        }
    }
}
