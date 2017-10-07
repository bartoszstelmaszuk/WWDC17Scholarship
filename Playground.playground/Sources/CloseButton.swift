import Foundation
import UIKit

class CloseButton: UIButton {
    let closeView = CloseButtonView()
    
    override var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                closeView.color = .lightGray
            case false:
                closeView.color = .gray
            }
            closeView.layoutSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        closeView.isUserInteractionEnabled = false
        addSubview(closeView)
        closeView.translatesAutoresizingMaskIntoConstraints = false
        let centerXCloseConstraint = NSLayoutConstraint(
            item: closeView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        let centerYCloseConstraint = NSLayoutConstraint(
            item: closeView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: 0
        )
        let widthCloseConstraint = NSLayoutConstraint(
            item: closeView,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 1,
            constant: 0
        )
        let heightCloseConstraint = NSLayoutConstraint(
            item: closeView,
            attribute: .height,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: 1,
            constant: 0
        )
        NSLayoutConstraint.activate([centerXCloseConstraint, centerYCloseConstraint, widthCloseConstraint, heightCloseConstraint])
        
        layoutIfNeeded()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
