//
//  ProductHuntVotes.swift
//  ProductHunt
//  
//
//  Created by Julien Lacroix on 05/11/2020.
//

/// We want ProductHuntVotes available for iOS, tvOS, and watchOS.
#if canImport(UIKit)
import Foundation



//MARK: - Class
@available(iOS 14, *)
class ProductHuntVotes: ObservableObject {
    
    
    
    //MARK: Properties
    @Published var votes: Int = 0
    private var observer: NSKeyValueObservation?
    
    
    
    //MARK: Lifecycle
    init(post: PHPost, token: String) {
        
        /// Initialize PHManager
        PHManager.shared.configure(forPost: post, token: token)
        
        /// Initialize observer
        observer = UserDefaults.standard.observe(\.productHuntVotesCount, options: [.initial, .new]) { [weak self] defaults, change in
            DispatchQueue.main.async {
                self?.votes = ( change.newValue ?? 0 )
            }
        }
    }
    
    deinit {
        observer?.invalidate()
    }
}



/// Endif
#endif
