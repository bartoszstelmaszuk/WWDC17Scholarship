import Foundation
import UIKit

enum ChatBubbleAction {
    case moreInfo
}

class ChatBubble: UIView {
    private let messageLabel = UILabel()
    private let moreButton = UIButton(type: .system)
    public var actionHandler: (ChatBubbleAction) -> Void
    
    required init() {
        self.actionHandler = { _ in }
        super.init(frame: .zero)
        configureSelf()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(message: String, isHiddenMoreButton: Bool) {
        if isHiddenMoreButton {
            moreButton.removeFromSuperview()
        } else {
            configureMoreButton()
        }
        messageLabel.text = message
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .bottomLeft, .bottomRight], radius: bounds.height / 4)
    }
    
    private func configureSelf() {
        messageLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        messageLabel.textColor = .black
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 0
        moreButton.setTitle("More...", for: .normal)
        moreButton.titleLabel?.font = .systemFont(ofSize: 14)
        backgroundColor = .white
        moreButton.addTarget(self, action: #selector(self.moreButtonDidTouch), for: .touchUpInside)
    }
    
    @objc private func moreButtonDidTouch() {
        actionHandler(.moreInfo)
    }
    
    private func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    private func configureConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
        let topConstraint = NSLayoutConstraint(
            item: messageLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: 10
        )
        let trailingConstraint = NSLayoutConstraint(
            item: messageLabel,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1,
            constant: -10
        )
        let leadingConstraint = NSLayoutConstraint(
            item: messageLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1,
            constant: 10
        )
        let bottomConstraint = NSLayoutConstraint(
            item: messageLabel,
            attribute: .bottom,
            relatedBy: .lessThanOrEqual,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: -10
        )
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
        
        configureMoreButton()
        self.layoutIfNeeded()
    }
    
    private func configureMoreButton() {
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(moreButton)
        let topButtonConstraint = NSLayoutConstraint(
            item: moreButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: messageLabel,
            attribute: .bottom,
            multiplier: 1,
            constant: 10
        )
        let bottomButtonConstraint = NSLayoutConstraint(
            item: moreButton,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: -10
        )
        let trailingButtonConstraint = NSLayoutConstraint(
            item: moreButton,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1,
            constant: -10
        )
        NSLayoutConstraint.activate([topButtonConstraint, bottomButtonConstraint, trailingButtonConstraint])
    }
}
