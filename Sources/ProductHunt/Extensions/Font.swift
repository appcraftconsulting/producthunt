//
//  Font.swift
//  ProductHunt
//
//  Created by Julien Lacroix on 05/11/2020.
//

/// We want ProductHuntVotes available for iOS, tvOS, and watchOS.
#if canImport(UIKit)
import SwiftUI

// MARK: - Extension
@available(iOS 14, *)
extension Font {
    static func defaultFont(size: CGFloat) -> Font {
        return .custom("HelveticaNeue-Bold", size: size)
    }
}
#endif
