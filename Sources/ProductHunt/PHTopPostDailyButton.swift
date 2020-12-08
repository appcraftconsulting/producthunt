//
//  PHTopPostDailyButton.swift
//  ProductHunt
//
//  Created by François Boulais on 07/12/2020.
//

#if canImport(UIKit)
import UIKit

@IBDesignable
public class PHTopPostDailyButton: UIButton {
    public enum Position: String {
        case first
        case second
        case third
        case fourth
        case fifth
        
        var value: Int {
            switch self {
            case .first:
                return 1
            case .second:
                return 2
            case .third:
                return 3
            case .fourth:
                return 4
            case .fifth:
                return 5
            }
        }
        
        var image: UIImage? {
            UIImage(named: "position/\(rawValue)", in: .module, compatibleWith: nil)
        }
        
        var title: String {
            "#\(value) Product of the Day"
        }
    }
    
    public var position: Position = .first
    
    convenience init(frame: CGRect, position: Position) {
        self.init(frame: frame)
        self.position = position

        setup()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = UIColor(asset: .border)?.cgColor
    }
    
    // MARK: - Private functions
    
    private func setup() {
        layer.cornerRadius = 12
        backgroundColor = UIColor(asset: .background)
        setImage(position.image, for: .normal)
        
        layer.borderWidth = 1
                
        adjustsImageWhenHighlighted = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 2
        paragraphStyle.alignment = .left
        
        var attributes = [NSAttributedString.Key : Any]()
        attributes[.font] = UIFont.defaultFont(ofSize: 2)
        attributes[.foregroundColor] = UIColor(asset: .foreground)
        attributes[.paragraphStyle] = paragraphStyle
        let attributedTitle = NSMutableAttributedString(string: " ", attributes: attributes)
        
        attributes[.font] = UIFont.defaultFont(ofSize: 10)
        attributedTitle.append(.init(string: String.buttonProductHunt.appending("\n"), attributes: attributes))
        
        attributes[.font] = UIFont.defaultFont(ofSize: 17)
        attributedTitle.append(.init(string: position.title, attributes: attributes))
        
        setAttributedTitle(attributedTitle, for: .normal)
        
        contentEdgeInsets = .init(top: 12, left: 32, bottom: 12, right: 32)
        titleEdgeInsets = .init(top: 0, left: 6, bottom: 0, right: -6)
        imageEdgeInsets = .init(top: 0, left: -6, bottom: 0, right: 6)
        
        titleLabel?.numberOfLines = 0
        
        addTarget(PHManager.shared, action: #selector(PHManager.shared.showPostPage), for: .touchUpInside)
    }
}
#endif
