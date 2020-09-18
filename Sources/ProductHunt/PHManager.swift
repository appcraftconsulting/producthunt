//
//  PHManager.swift
//  ProductHunt
//
//  Created by François Boulais on 17/09/2020.
//

#if canImport(UIKit)
import SafariServices
import UIKit

public class PHManager: NSObject, SFSafariViewControllerDelegate {
    public static let shared = PHManager()
        
    /// The view controller used to present post page.
    public var presentingViewController: UIViewController?
    
    private var session = URLSession.shared
    public var token: String?
    private var post: PHPost?

    private override init() {
        super.init()
        
        Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { [weak self] timer in
            self?.fetchVotesCount()
        }
    }
    
    // MARK: - Public functions
    
    /**
     Configure the manager for product synchronization
     - parameters:
        - post: The post that will be linked to the `PHButton` (either defined with slug or id)
        - token: Your Product Hunt developer token
     */
    public func configure(forPost post: PHPost, using token: String) {
        self.post = post
        self.token = token
        
        fetchVotesCount()
    }
    
    // MARK: - Internal functions
    
    @objc internal func showPostPage() {
        guard let presentingViewController = presentingViewController else {
            fatalError("presentingViewController must be set.")
        }
        
        if let url = post?.url {
            let viewController = SFSafariViewController(url: url)
            viewController.preferredControlTintColor = UIColor(asset: .foreground)
            viewController.modalPresentationStyle = .formSheet
            viewController.delegate = self
            presentingViewController.present(viewController, animated: true)
        }
    }
    
    // MARK: - SFSafariViewControllerDelegate
    
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        fetchVotesCount()
    }
    
    // MARK: - Private functions

    @objc private func fetchVotesCount() {
        guard let post = post, let token = token else {
            fatalError("PHManager instance has not been configured.")
        }
        
        guard let url = URL(string: "https://api.producthunt.com/v2/api/graphql") else {
            return
        }
        
        let parameters : [String : Any] = ["query" : post.query]
        let data = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.httpBody = data
        
        DispatchQueue(label: "NetworkThread").async {
            let task = self.session.dataTask(with: request) { data, response, error in
                if let data = data, let response = try? JSONDecoder().decode(PHResponse.self, from: data) {
                    if let votesCount = response.data?.post.votesCount {
                        DispatchQueue.main.async {
                            print("New votes count received: \(votesCount)")
                            UserDefaults.standard.setVotesCount(votesCount)
                        }
                    } else if let description = response.errors?.first?.description {
                        print(description)
                    } else if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) {
                        print(jsonObject)
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
            
            task.resume()
        }
    }
}
#endif
