//
//  UIColor.swift
//  ProductHunt
//
//  Created by François Boulais on 17/09/2020.
//

#if canImport(UIKit)
import UIKit

enum ColorAsset: String {
    case foreground, background, border
}

extension UIColor {
    convenience init?(asset: ColorAsset) {
        self.init(named: asset.rawValue, in: .module, compatibleWith: nil)
    }
}
#endif
