//
//  ProductHuntButton.swift
//  ProductHunt
//
//  Created by Julien Lacroix on 04/11/2020.
//

/// We want ProductHuntButton available for iOS, tvOS, and watchOS.
#if canImport(UIKit)
import SwiftUI
import SafariServices



//MARK: - View
@available(iOS 14, *)
public struct ProductHuntButton: View {
    
    
    
    //MARK: Properties
    @State private var isShowingSafariView: Bool = false
    @ObservedObject private var productHuntVotes: ProductHuntVotes
    private var post: PHPost
    
    
    
    //MARK: Lifecycle
    public init(post: PHPost, token: String) {
        self.post = post
        self.productHuntVotes = ProductHuntVotes(post: post, token: token)
    }
    
    
    
    //MARK: Body
    public var body: some View {
        Button(action: { isShowingSafariView = true }, label: {
            ZStack {
                Color("background")
                RoundedRectangle(cornerRadius: 12.0).stroke(Color("border"), lineWidth: 2.0)
                HStack {
                    Image("logo")
                    VStack(alignment: .leading, spacing: -2.0) {
                        Text("FEATURED ON")
                            .foregroundColor(Color("foreground"))
                            .font(.custom("HelveticaNeue-Bold", size: 8.0))
                        Text("Product Hunt")
                            .foregroundColor(Color("foreground"))
                            .font(.custom("HelveticaNeue-Bold", size: 22.0))
                    }
                    Spacer()
                    Text("▲\n\(productHuntVotes.votes)")
                        .foregroundColor(Color("foreground"))
                        .font(.custom("HelveticaNeue-Bold", size: 14.0))
                        .multilineTextAlignment(.center)
                }
                .padding(EdgeInsets(top: 5.0, leading: 20.0, bottom: 5.0, trailing: 20.0))
            }
            .clipShape(RoundedRectangle(cornerRadius: 12.0))
        })
        .sheet(isPresented: $isShowingSafariView, content: presentSafariViewIfNecessary)
    }
    
    
    
    //MARK: Private methods
    @ViewBuilder private func presentSafariViewIfNecessary() -> some View {
        if let url = post.url {
            SafariView(url: url)
        }
    }
}



@available(iOS 14, *)
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}



/// Endif
#endif
