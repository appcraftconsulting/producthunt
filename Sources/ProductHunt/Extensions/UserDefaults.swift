//
//  UserDefaults.swift
//  ProductHunt
//
//  Created by François Boulais on 17/09/2020.
//

import Foundation

extension UserDefaults {
    private var key: String {
        "productHuntVotesCount"
    }
    
    @objc internal dynamic var productHuntVotesCount: Int {
        integer(forKey: key)
    }
    
    internal func setVotesCount(_ votesCount: Int) {
        setValue(votesCount, forKey: key)
        synchronize()
    }
}
