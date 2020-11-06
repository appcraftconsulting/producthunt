//
//  PHVotes.swift
//  ProductHunt
//
//  Created by Julien Lacroix on 05/11/2020.
//

#if canImport(UIKit)
import Foundation

// MARK: - Class

@available(iOS 14, *)
class PHVotes: ObservableObject {

    // MARK: - Properties
    
    @Published var value: Int = 0
    private var observer: NSKeyValueObservation?
        
    // MARK: - Lifecycle
    
    init(post: PHPost, token: String) {
        PHManager.shared.configure(forPost: post, token: token)
        
        observer = UserDefaults.standard.observe(\.productHuntVotesCount, options: [.initial, .new]) { [weak self] defaults, change in
            DispatchQueue.main.async {
                self?.value = ( change.newValue ?? 0 )
            }
        }
    }
    
    deinit {
        observer?.invalidate()
    }
}
#endif
