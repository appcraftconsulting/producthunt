//
//  Color.swift
//  ProductHunt
//
//  Created by Julien Lacroix on 05/11/2020.
//

/// We want ProductHuntVotes available for iOS, tvOS, and watchOS.
#if canImport(UIKit)
import SwiftUI

// MARK: - Extension
@available(iOS 14, *)
extension Color {
    static var background: Color {
        return Color("background")
    }
    
    static var foreground: Color {
        return Color("foreground")
    }
    
    static var border: Color {
        return Color("border")
    }
}
#endif
