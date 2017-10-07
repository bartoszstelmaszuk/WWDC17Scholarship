import Foundation
import UIKit

class InfoButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                backgroundColor = .lightGray
            case false:
                backgroundColor = .clear
            }
        }
    }
    
    required init() {
        super.init(frame: .zero)
        setTitle("i", for: .normal)
        setTitleColor(.gray, for: .selected)
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width / 2.0
    }
    
}
