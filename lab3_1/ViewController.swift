//
//  ViewController.swift
//  lab3_1
//
//  Created by Nikash Taskar on 10/1/19.
//  Copyright © 2019 Nikash Taskar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var drawingView: UIView!
    var canvas:ShapeView!
    var currWidth:CGFloat!
    var currColor:UIColor!
    var currShape:Shape?
    var shapeList:[Shape]?
    var sampleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currWidth = 20
        currColor = UIColor.red
        canvas = ShapeView(frame: drawingView.frame)
        
        sampleTextField =  UITextField(frame: CGRect(x: (view.frame.width-300)/2, y:90, width: 300, height: 40))
        sampleTextField.text = "Enter text here"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        //        sampleTextField.delegate = self as! UITextFieldDelegate
        view.addSubview(canvas)
    }

    @IBAction func clearCanvas(_ sender: Any) {
        canvas.shapeList = []
        canvas.shape = nil
    }
    
    @IBAction func undoCanvas(_ sender: Any) {
        if(canvas.shapeList.count > 0){
            canvas?.shapeList.removeLast()
        }
        currShape = Shape(points: [], width: currWidth, color: currColor)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        currWidth = CGFloat(sender.value)
    }
    
    @IBAction func saveImage(_ sender: Any) {
//        https://stackoverflow.com/questions/25448879/how-do-i-take-a-full-screen-screenshot-in-swift
        //Create the UIImage
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
    }
    
    @IBAction func colorChanged(_ sender: UIButton) {
        currColor = sender.backgroundColor
    }
    
    @IBAction func changeBackground(_ sender: UIButton) {
        drawingView.backgroundColor = currColor
    }
    
    @IBAction func addText(_ sender: Any) {
        view.addSubview(sampleTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(touches.first?.location(in: view!))
        currShape = Shape(points: [], width: currWidth, color: currColor)
        currShape!.points.append((touches.first?.location(in: drawingView!))!)
        canvas?.shapeList.append(currShape!)
        currShape = Shape(points: [], width: currWidth, color: currColor)
//        canvas!.shape!.points.append((touches.first?.location(in: view!))!)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if(touches.first == nil){return}
        
//        currShape = Shape(points: [], width: currWidth, color: currColor)
        
        for touch in touches{
//            print(touch.location(in: view!))
            currShape!.points.append((touch.location(in: drawingView!)))
        }
        canvas?.shapeList.append(currShape!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//            print(touches.first?.location(in: view!))
            currShape = Shape(points: [], width: currWidth, color: currColor)
            currShape!.points.append((touches.first?.location(in: drawingView!))!)
//            canvas?.shapeList.append(currShape!)
        
    }
}

