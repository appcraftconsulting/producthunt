//
//  ProductHuntButton.swift
//  ProductHunt
//
//  Created by Julien Lacroix on 04/11/2020.
//

#if canImport(UIKit)
import SwiftUI
import SafariServices

// MARK: - View

@available(iOS 14, *)
public struct ProductHuntButton: View {
        
    // MARK: - Properties
    
    @State private var isShowingSafariView: Bool = false
    @ObservedObject private var votesCount: PHVotesCount
    
    private var post: PHPost
        
    // MARK: - Lifecycle
    
    public init(post: PHPost, token: String) {
        self.post = post
        self.votesCount = .init(post: post, token: token)
    }
        
    // MARK: - Body
    
    public var body: some View {
        Button(action: { isShowingSafariView = true }, label: {
            ZStack {
                Color.background
                RoundedRectangle(cornerRadius: 12.0).stroke(Color.border, lineWidth: 2.0)
                HStack {
                    Image("logo")
                    VStack(alignment: .leading, spacing: -2.0) {
                        Text(String.buttonFeaturedOn)
                            .foregroundColor(.foreground)
                            .font(.defaultFont(size: 8.0))
                        Text(String.buttonProductHunt)
                            .foregroundColor(.foreground)
                            .font(.defaultFont(size: 22.0))
                    }
                    Spacer()
                    Text([.buttonUpvote, .init(votesCount.value)].joined(separator: "\n"))
                        .foregroundColor(.foreground)
                        .font(.defaultFont(size: 14.0))
                        .multilineTextAlignment(.center)
                }
                .padding(EdgeInsets(top: 5.0, leading: 20.0, bottom: 5.0, trailing: 20.0))
            }
            .clipShape(RoundedRectangle(cornerRadius: 12.0))
        })
        .sheet(isPresented: $isShowingSafariView, content: presentSafariViewIfNecessary)
    }
    
    // MARK: - Private functions
    
    @ViewBuilder private func presentSafariViewIfNecessary() -> some View {
        if let url = post.url {
            SafariView(url: url)
        }
    }
}

// MARK: - SafariView
@available(iOS 14, *)
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        .init(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) { }
}
#endif
