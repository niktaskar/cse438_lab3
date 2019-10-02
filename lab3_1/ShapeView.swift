//
//  shapeView.swift
//  lab3_1
//
//  Created by Nikash Taskar on 10/1/19.
//  Copyright © 2019 Nikash Taskar. All rights reserved.
//

import Foundation
import UIKit

class ShapeView: UIView {
    
    var shape:Shape? {
        didSet{
            setNeedsDisplay()
        }
    }
    
    var shapeList:[Shape] = [] {
        didSet{
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        for shape in shapeList{
            drawShape(shape: shape)
        }
        
        if(shape != nil){
            drawShape(shape: shape!)
        }
    }
    
    func drawShape(shape: Shape){
        shape.color.setFill()
        
        var path = UIBezierPath()
        path.addArc(withCenter: shape.points[0], radius: (shape.width)/2, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
        if(shape.points.count <= 2) {
            path.fill()
        }
        else {
            path = createQuadPath(points: shape.points)
            path.lineWidth = shape.width
            shape.color.setStroke()
            path.lineJoinStyle = .round
            path.lineCapStyle = .round
            path.stroke()
        }
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        // implement this function here
        return CGPoint(x: (first.x+second.x)/2, y: (first.y+second.y)/2)
    }
    
    private func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath() //Create the path object
        if(points.count < 2){ //There are no points to add to this path
            return path
        }
        path.move(to: points[0]) //Start the path on the first point
        for i in 1..<points.count - 1{
            let firstMidpoint = midpoint(first: path.currentPoint, second:
                points[i]) //Get midpoint between the path's last point and the next one in the array
            let secondMidpoint = midpoint(first: points[i], second:
                points[i+1]) //Get midpoint between the next point in the array and the one after it
            path.addCurve(to: secondMidpoint, controlPoint1: firstMidpoint,
                          controlPoint2: points[i]) //This creates a cubic Bezier curve using math!
        }
        return path
    }
}
