//
//  PHButton.swift
//  ProductHunt
//
//  Created by François Boulais on 14/09/2020.
//

#if canImport(UIKit)
import UIKit

@IBDesignable
public class PHButton: UIButton {
    private let upvotesLabel = UILabel()
    private var observer: NSKeyValueObservation?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        addObservers()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
        addObservers()
    }
    
    deinit {
        observer?.invalidate()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = UIColor(asset: .border)?.cgColor
    }
    
    // MARK: - Internal functions
    
    internal func setVotesCount(_ votesCount: Int?) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = -2
        paragraphStyle.alignment = .center
        
        var attributes = [NSAttributedString.Key : Any]()
        attributes[.font] = UIFont.defaultFont(ofSize: 14)
        attributes[.foregroundColor] = UIColor(asset: .foreground)
        attributes[.paragraphStyle] = paragraphStyle
    
        upvotesLabel.attributedText = .init(string: "▲\n\(votesCount ?? 0)", attributes: attributes)
    }
    
    // MARK: - Private functions
    
    private func setup() {
        layer.cornerRadius = 12
        backgroundColor = UIColor(asset: .background)
        let image = UIImage(named: "logo", in: .module, compatibleWith: nil)
        setImage(image, for: .normal)
        
        layer.borderWidth = 1
                
        adjustsImageWhenHighlighted = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = -2
        paragraphStyle.alignment = .left
        
        var attributes = [NSAttributedString.Key : Any]()
        attributes[.font] = UIFont.defaultFont(ofSize: 4)
        attributes[.foregroundColor] = UIColor(asset: .foreground)
        attributes[.paragraphStyle] = paragraphStyle
        let attributedTitle = NSMutableAttributedString(string: " ", attributes: attributes)
        
        attributes[.font] = UIFont.defaultFont(ofSize: 8)
        attributedTitle.append(.init(string: "FEATURED ON\n", attributes: attributes))
        
        attributes[.font] = UIFont.defaultFont(ofSize: 22)
        attributedTitle.append(.init(string: "Product Hunt", attributes: attributes))
        
        setAttributedTitle(attributedTitle, for: .normal)
        
        contentEdgeInsets = .init(top: 10, left: 14, bottom: 8, right: 62)
        titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -4)
        imageEdgeInsets = .init(top: 0, left: -4, bottom: 0, right: 4)
        
        upvotesLabel.translatesAutoresizingMaskIntoConstraints = false
        upvotesLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        upvotesLabel.minimumScaleFactor = 0.5
        upvotesLabel.numberOfLines = 2
        
        addSubview(upvotesLabel)
    
        upvotesLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        if let titleLabel = titleLabel {
            titleLabel.numberOfLines = 0
            upvotesLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 8).isActive = true
        }
    }
    
    private func addObservers() {
        addTarget(PHManager.shared, action: #selector(PHManager.shared.showPostPage), for: .touchUpInside)

        observer = UserDefaults.standard.observe(\.productHuntVotesCount, options: [.initial, .new]) { [weak self] defaults, change in
            self?.setVotesCount(change.newValue)
        }
    }
}
#endif
