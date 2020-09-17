//
//  PHPost.swift
//  ProductHunt
//
//  Created by François Boulais on 17/09/2020.
//

import Foundation

public enum PHPost {
    case id(Int)
    case slug(String)
    
    internal var query: String {
        switch self {
        case let .id(id):
            return "{post(id: \(id)){votesCount}}"
        case let .slug(slug):
            return "{post(slug: \"\(slug)\"){votesCount}}"
        }
    }
    
    internal var url: URL? {
        switch self {
        case let .id(id):
            return URL(string: "https://www.producthunt.com/posts/\(id)")
        case let .slug(slug):
            return URL(string: "https://www.producthunt.com/posts/\(slug)")
        }
    }
}
