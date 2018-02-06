//
//  SlantedView.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation

@IBDesignable
class SlantedView: UIView {
    
    @IBInspectable var slantHeight: CGFloat = 50 { didSet { updatePath() } }
    
    private let shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 0
        shapeLayer.fillColor = UIColor.white.cgColor    // with masks, the color of the shape layer doesn’t matter; it only uses the alpha channel; the color of the view is dictate by its background color
        return shapeLayer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePath()
    }
    
    private func updatePath() {
        let path = UIBezierPath()
        path.move(to: bounds.origin)
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY - slantHeight))
        path.close()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
}
