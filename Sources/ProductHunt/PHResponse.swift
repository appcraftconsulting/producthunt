//
//  PHResponse.swift
//  ProductHunt
//
//  Created by François Boulais on 17/09/2020.
//

import Foundation

struct PHResponse: Decodable {
    struct Data: Decodable {
        struct Post: Decodable {
            let votesCount: Int
        }
        
        let post: Post
    }
    
    struct Error: Decodable {
        let description: String
        
        enum CodingKeys: String, CodingKey {
            case description = "error_description"
        }
    }
    
    let data: Data?
    let errors: [Error]?
}
