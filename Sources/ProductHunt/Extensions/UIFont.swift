//
//  UIFont.swift
//  ProductHunt
//
//  Created by François Boulais on 17/09/2020.
//

#if canImport(UIKit)
import UIKit

extension UIFont {
    static func defaultFont(ofSize fontSize: CGFloat) -> UIFont? {
        UIFont(name: "HelveticaNeue-Bold", size: fontSize)
    }
}
#endif
