import Foundation
import UIKit

struct DetailedInformationConfiguration {
    let text: String
    let image: UIImage
    let showCloseButton: Bool
}

class DetailedInformationScrollView: UIScrollView {
    private let containerView = UIView()
    private let imageView: UIImageView
    private let textLabel = UILabel()
    private let closeButton = CloseButton()
    private let upperSeparator = UIView()
    private let lowerSeparator = UIView()
    
    private let configuration: DetailedInformationConfiguration
    
    init(frame: CGRect, configuration: DetailedInformationConfiguration) {
        imageView = UIImageView(image: configuration.image)
        self.configuration = configuration
        super.init(frame: frame)
        configureSelf()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSelf() {
        backgroundColor = .white
        containerView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        textLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16.0)
        textLabel.textAlignment = .justified
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
        textLabel.text = configuration.text
        closeButton.addTarget(self, action: #selector(self.closeView), for: .touchUpInside)
    }
    
    @objc private func closeView() {
        UIView.animate(
            withDuration: 0.3,
            animations: { self.alpha = 0 },
            completion: { _ in self.removeFromSuperview() }
        )
    }
    
    private func configureConstraints() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(textLabel)
        containerView.addSubview(upperSeparator)
        containerView.addSubview(lowerSeparator)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let topContainerConstraint = NSLayoutConstraint(
            item: containerView,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
        let bottomContainerConstraint = NSLayoutConstraint(
            item: containerView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        let leadingContainerConstraint = NSLayoutConstraint(
            item: containerView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        )
        let trailingContainerConstraint = NSLayoutConstraint(
            item: containerView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        )
        let widthContainerConstraint = NSLayoutConstraint(
            item: containerView,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 1,
            constant: 0
        )
        let heightContainerConstraint = NSLayoutConstraint(
            item: containerView,
            attribute: .height,
            relatedBy: .greaterThanOrEqual,
            toItem: self,
            attribute: .height,
            multiplier: 1,
            constant: 0
        )
        NSLayoutConstraint.activate(
            [topContainerConstraint,
             bottomContainerConstraint, 
             leadingContainerConstraint,
             trailingContainerConstraint,
             widthContainerConstraint,
             heightContainerConstraint]
        )
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        upperSeparator.translatesAutoresizingMaskIntoConstraints = false
        lowerSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        if configuration.showCloseButton {
            containerView.addSubview(closeButton)
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            let centerXCloseConstraint = NSLayoutConstraint(
                item: closeButton,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .trailing,
                multiplier: 1,
                constant: -25
            )
            let centerYCloseConstraint = NSLayoutConstraint(
                item: closeButton,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: containerView,
                attribute: .top,
                multiplier: 1,
                constant: 25
            )
            let widthCloseConstraint = NSLayoutConstraint(
                item: closeButton,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 15
            )
            let heightCloseConstraint = NSLayoutConstraint(
                item: closeButton,
                attribute: .height,
                relatedBy: .equal,
                toItem: closeButton,
                attribute: .width,
                multiplier: 1,
                constant: 0
            )
            NSLayoutConstraint.activate(
                [centerXCloseConstraint, centerYCloseConstraint, widthCloseConstraint, heightCloseConstraint]
            )
        }
        
        let centerXImageConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        let topImageConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .top,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .top,
            multiplier: 1,
            constant: 60
        )
        let widthImageConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .width,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .width,
            multiplier: 0.75,
            constant: 0
        )
        NSLayoutConstraint.activate([centerXImageConstraint, topImageConstraint, widthImageConstraint])
        
        let leadingLabelConstraint = NSLayoutConstraint(
            item: textLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .leading,
            multiplier: 1,
            constant: 20
        )
        let trailingLabelConstraint = NSLayoutConstraint(
            item: textLabel,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .trailing,
            multiplier: 1,
            constant: -20
        )
        NSLayoutConstraint.activate([leadingLabelConstraint, trailingLabelConstraint])
        
        let leadingUpperSeparatorLabelConstraint = NSLayoutConstraint(
            item: upperSeparator,
            attribute: .leading,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        )
        let trailingUpperSeparatorLabelConstraint = NSLayoutConstraint(
            item: upperSeparator,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        )
        let topUpperSeparatorLabelConstraint = NSLayoutConstraint(
            item: upperSeparator,
            attribute: .top,
            relatedBy: .equal,
            toItem: imageView,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        let bottomUpperSeparatorLabelConstraint = NSLayoutConstraint(
            item: upperSeparator,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: textLabel,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
        
        NSLayoutConstraint.activate(
            [leadingUpperSeparatorLabelConstraint,
             trailingUpperSeparatorLabelConstraint,
             topUpperSeparatorLabelConstraint,
             bottomUpperSeparatorLabelConstraint]
        )
        
        let leadingLowerSeparatorLabelConstraint = NSLayoutConstraint(
            item: lowerSeparator,
            attribute: .leading,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        )
        let trailingLowerSeparatorLabelConstraint = NSLayoutConstraint(
            item: lowerSeparator,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        )
        let topLowerSeparatorLabelConstraint = NSLayoutConstraint(
            item: lowerSeparator,
            attribute: .top,
            relatedBy: .equal,
            toItem: textLabel,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        let bottomLowerSeparatorLabelConstraint = NSLayoutConstraint(
            item: lowerSeparator,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        let heightLowerSeparatorLabelConstraint = NSLayoutConstraint(
            item: lowerSeparator,
            attribute: .height,
            relatedBy: .equal,
            toItem: upperSeparator,
            attribute: .height,
            multiplier: 1,
            constant: 0
        )
        NSLayoutConstraint.activate(
            [leadingLowerSeparatorLabelConstraint,
             trailingLowerSeparatorLabelConstraint,
             topLowerSeparatorLabelConstraint,
             bottomLowerSeparatorLabelConstraint,
             heightLowerSeparatorLabelConstraint]
        )
        
        layoutIfNeeded()
    }
}
