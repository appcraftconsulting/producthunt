//
//  PHManager.swift
//  ProductHunt
//
//  Created by François Boulais on 17/09/2020.
//

#if canImport(UIKit)
import SafariServices
import UIKit

public class PHManager {
    public static let shared = PHManager()
    
    /// The post that will be linked to the `PHButton`.
    public var post: PHPost? {
        didSet {
            fetchVotesCount()
        }
    }
    
    /// The view controller used to present post page.
    public var presentingViewController: UIViewController?
    
    private var session = URLSession.shared
    private let token = "Ou0qvqpdX7dT1Y4h4CSK3aKMW6-BaxzE6MxDNeop1Zk"
    
    private init() {
        Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { [weak self] timer in
            self?.fetchVotesCount()
        }
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
            presentingViewController.present(viewController, animated: true)
        }
    }
    
    // MARK: - Private functions

    @objc private func fetchVotesCount() {
        guard let url = URL(string: "https://api.producthunt.com/v2/api/graphql"), let post = post else {
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
