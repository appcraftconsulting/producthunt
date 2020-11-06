//
//  Color.swift
//  ProductHunt
//
//  Created by Julien Lacroix on 05/11/2020.
//

#if canImport(UIKit)
import SwiftUI

// MARK: - Extension

@available(iOS 14, *)
extension Color {
    static var background: Color {
        .init("background")
    }
    
    static var foreground: Color {
        .init("foreground")
    }
    
    static var border: Color {
        .init("border")
    }
}
#endif
