import Foundation
import UIKit

class CloseButtonView: UIView {
    
    var color: UIColor = .gray
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawLineFrom(
            start: frame.origin, 
            toPoint: CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y + frame.height),
            ofColor: color
        )
        drawLineFrom(
            start: CGPoint(x: frame.origin.x, y: frame.origin.y + frame.height),
            toPoint: CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y),
            ofColor: color
        )
    }
    
    func drawLineFrom(start: CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor) {
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 5.0
        
        layer.addSublayer(shapeLayer)
    }
}
