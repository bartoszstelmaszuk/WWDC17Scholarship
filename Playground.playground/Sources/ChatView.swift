import Foundation
import UIKit

enum ChatViewAction {
    case showPainterInfo
    case didTapBubble
}

class ChatView: UIView {
    private let clownView: UIImageView
    private let bubble = ChatBubble()
    private let button = InfoButton()
    private var detailedView: UIView?
    
    private let actionHandler: (ChatViewAction) -> Void
    
    var currentBubbleFrame: CGRect { return bubble.frame }
    
    required init(actionHandler: @escaping (ChatViewAction) -> Void) {
        let image = UIImage(named: "stanczyk.jpg")
        clownView = UIImageView(image: image)
        clownView.contentMode = .scaleAspectFill
        self.actionHandler = actionHandler
        super.init(frame: .zero)
        bubble.actionHandler = { [weak self] action in self?.handle(action: action) }
        button.addTarget(self, action: #selector(self.showPainterInfo), for: .touchUpInside)
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func handle(action: ChatBubbleAction) {
        switch action {
        case .moreInfo:
            actionHandler(.didTapBubble)
        }
    }
        
    func showMessage(message: String, isHiddenMoreButton: Bool = false) {
        UIView.animate(withDuration: 0.3, animations: {
           self.detailedView?.alpha = 0
        }, completion: { _ in
            self.detailedView?.removeFromSuperview()
            self.bubble.alpha = 0
            self.bubble.set(message: message, isHiddenMoreButton: isHiddenMoreButton)
            UIView.animate(withDuration: 0.3, animations: { self.bubble.alpha = 1 }) { _ in
                _ = Timer.scheduledTimer(
                    timeInterval: 6,
                    target: self,
                    selector: #selector(self.hideMessage),
                    userInfo: nil,
                    repeats: false
                )
            }
        })
    }
    
    @objc func hideMessage() {
        UIView.animate(withDuration: 0.3) {
            self.bubble.alpha = 0
        }
    }
    
    func transitionTo(detailedViewConfiguration: DetailedInformationConfiguration) {
        let transitionView = UIView(frame: bubble.frame)
        transitionView.backgroundColor = .white
        transitionView.alpha = 0
        transitionView.layer.cornerRadius = transitionView.bounds.height / 4
        addSubview(transitionView)
        UIView.animate(withDuration: 0.3, animations: {
            transitionView.alpha = 1
        }, completion: { _ in
            let rect =  CGRect(x: 15, y: 15, width: self.bounds.width - 30, height: self.bounds.height - 30)
            UIView.animate(withDuration: 1, animations: {
                transitionView.frame = rect
                self.bubble.alpha = 0
            }, completion: { _ in
                self.detailedView = DetailedInformationScrollView(
                    frame: transitionView.frame,
                    configuration: detailedViewConfiguration
                )
                self.detailedView?.layer.cornerRadius = transitionView.layer.cornerRadius
                self.detailedView?.alpha = 0
                self.addSubview(self.detailedView!)
                UIView.animate(withDuration: 0.3, animations: { 
                    self.detailedView?.alpha = 1
                }, completion: { _ in
                    transitionView.removeFromSuperview()
                })
            })
        })
    }
    
    @objc private func showPainterInfo() {
        actionHandler(.showPainterInfo)
    }
    
    private func configureConstraints() {
        addSubview(clownView)
        clownView.translatesAutoresizingMaskIntoConstraints = false
        let topClownConstraint = NSLayoutConstraint(
            item: clownView,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
        let bottomClownConstraint = NSLayoutConstraint(
            item: clownView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        let leadingClownConstraint = NSLayoutConstraint(
            item: clownView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        )
        let trailingClownConstraint = NSLayoutConstraint(
            item: clownView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        )
        NSLayoutConstraint.activate(
            [topClownConstraint, bottomClownConstraint, leadingClownConstraint, trailingClownConstraint]
        )
        
        addSubview(bubble)
        bubble.alpha = 0
        bubble.translatesAutoresizingMaskIntoConstraints = false
        let leadingBubbleConstraint = NSLayoutConstraint(
            item: bubble,
            attribute: .leading,
            relatedBy: .greaterThanOrEqual,
            toItem: self,
            attribute: .leading,
            multiplier: 1,
            constant: 20
        )
        let trailingBubbleConstraint = NSLayoutConstraint(
            item: bubble,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 40
        )
        let topBubbleConstraint = NSLayoutConstraint(
            item: bubble,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: -90
        )
        NSLayoutConstraint.activate([leadingBubbleConstraint, trailingBubbleConstraint, topBubbleConstraint])
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let centerXBubbleConstraint = NSLayoutConstraint(
            item: button,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1,
            constant: -50
        )
        let centerYButtonConstraint = NSLayoutConstraint(
            item: button,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: -50
        )
        let widthButtonConstraint = NSLayoutConstraint(
            item: button,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .width,
            multiplier: 1,
            constant: 50
        )
        let heightButtonConstraint = NSLayoutConstraint(
            item: button,
            attribute: .height,
            relatedBy: .equal,
            toItem: button,
            attribute: .width,
            multiplier: 1,
            constant: 0
        )
        NSLayoutConstraint.activate(
            [centerXBubbleConstraint, centerYButtonConstraint, widthButtonConstraint, heightButtonConstraint]
        )
        
        layoutIfNeeded()
    }
}
