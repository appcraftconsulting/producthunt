//
//  Font.swift
//  ProductHunt
//
//  Created by Julien Lacroix on 05/11/2020.
//

#if canImport(UIKit)
import SwiftUI

// MARK: - Extension

@available(iOS 14, *)
extension Font {
    static func defaultFont(size: CGFloat) -> Font {
        .custom("HelveticaNeue-Bold", size: size)
    }
}
#endif
