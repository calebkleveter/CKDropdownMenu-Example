//
//  IonIcons.swift
//  CKDropdown-Example
//
//  Created by Caleb Kleveter on 9/6/16.
//  Copyright © 2016 Caleb Kleveter. All rights reserved.
//

import Foundation
import UIKit

// The output below is limited by 4 KB.
// Upgrade your plan to remove this limitation.

//
//  IonIcons.m
//  ionicons-iOS is Copyright 2013 TapTemplate and released under the MIT license.
//  http://www.taptemplate.com
//  ==========================
//
import QuartzCore
class IonIcons {
    
//    convenience init(size: CGFloat) {
//        return UIFont(name: "ionicons", size: size)
//    }
    
    class func font(withSize size: CGFloat) -> UIFont? {
        if let font = UIFont(name: "ionicons", size: size) {
            return font
        } else {
            return nil
        }
        
    }
    
    class func labelWithIcon(icon_name: String, size: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        IonIcons.label(label: label, setIcon: icon_name, size: size, color: color, sizeToFit: true)
        return label
    }
    
    class func label(label: UILabel, setIcon icon_name: String, size: CGFloat, color: UIColor, sizeToFit shouldSizeToFit: Bool) {
        label.font = IonIcons.font(withSize: size)
        label.text = icon_name
        label.textColor = color
        label.backgroundColor = UIColor.clear()
        if shouldSizeToFit {
            label.sizeToFit()
        }
        // NOTE: ionicons will be silent through VoiceOver, but the Label is still selectable through VoiceOver. This can cause a usability issue because a visually impaired user might navigate to the label but get no audible feedback that the navigation happened. So hide the label for VoiceOver by default - if your label should be descriptive, un-hide it explicitly after creating it, and then set its accessibiltyLabel.
        label.accessibilityElementsHidden = true
    }
    
    class func imageWithIcon(icon_name: String, size: CGFloat, color: inout UIColor?) -> UIImage? {
        if color != nil {
            return IonIcons.imageWithIcon(icon_name: icon_name, iconColor: &color, iconSize: size, imageSize: CGSize(width: size, height: size))
        } else {
            print("\(Date.init()): CKDropdownMenu - Color does not exist.")
            return nil
        }
    }
    
    class func imageWithIcon(icon_name: String, iconColor: inout UIColor?, iconSize: CGFloat, imageSize: CGSize) -> UIImage? {
//        assert(icon_name, "You must specify an icon from ionicons-codes.h.")
        if CFloat(UIDevice.current().systemVersion) >= 6 {
            if iconColor == nil {
                iconColor = .black()
            }
            var attString = AttributedString()
            UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
            if let iconFont = IonIcons.font(withSize: iconSize) {
                if let color = iconColor {
                    attString = AttributedString(string: icon_name, attributes: [NSFontAttributeName: iconFont, NSForegroundColorAttributeName: color])
                } else {
                    print("\(Date.init()): CKDropdownMenu - Color does not exist. Line 76.")
                }
            } else {
                print("\(Date.init()): CKDropdownMenu - Font does not exist. line 79.")
            }
            
            // get the target bounding rect in order to center the icon within the UIImage:
            let ctx = NSStringDrawingContext.init()
            let boundingRect = attString.boundingRect(with: CGSize(width: iconSize, height: iconSize), options: [], context: ctx)
            // draw the icon string into the image:
            attString.draw(in: CGRect(x: (imageSize.width / 2.0) - boundingRect.size.width / 2.0, y: (imageSize.height / 2.0) - boundingRect.size.height / 2.0, width: imageSize.width, height: imageSize.height))
            var iconImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            if iconColor != nil && (iconImage?.responds(to: #selector(iconImage?.withRenderingMode)) != nil) {
                iconImage = iconImage?.withRenderingMode(.alwaysOriginal)
            }
            
            
            if let image = iconImage {
                return image
            } else {
                return nil
            }
        }
        else {
            #if DEBUG
                print(" [ IonIcons ] Using lower-res iOS 5-compatible image rendering.")
            #endif
            guard let color = iconColor else {
                print("\(Date.init()): CKDropdownMenu - Color does not exist.")
                return nil
            }
            let iconLabel = IonIcons.labelWithIcon(icon_name: icon_name, size: iconSize, color: color)
            var iconImage: UIImage? = nil
            UIGraphicsBeginImageContextWithOptions(imageSize, false, 1.0)
            do {
                let imageContext = UIGraphicsGetCurrentContext()
                if let imageContext = imageContext {
                    UIGraphicsPushContext(imageContext)
                    do {
                        imageContext.translate(x: (imageSize.width / 2.0) - iconLabel.frame.size.width / 2.0, y: (imageSize.height / 2.0) - iconLabel.frame.size.height / 2.0)
                        iconLabel.layer.render(in: imageContext)
                    }
                    UIGraphicsPopContext()
                }
                iconImage = UIGraphicsGetImageFromCurrentImageContext()
            }
            UIGraphicsEndImageContext()
            return iconImage!
        }
    }
}
