//
//  ViewController.swift
//  CoreMLTest
//
//  Created by cafe on 2017/8/29.
//  Copyright © 2017年 cafe. All rights reserved.
//

import UIKit
import CoreML


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage(named: "cats")
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        
        
        
        let model = MobileNet()
        
        if let imageToPredict = imageView.image?.cgImage {
            
            if let buffer = ImageProcessor.pixelBuffer(forImage: imageToPredict) {
                
                do {
                
                    let output = try model.prediction(image: buffer)
                    print("label \(output.classLabel)")
                    print("\(output.classLabelProbs)")
                    
                } catch {
                    
                    print("error occured")
                    
                }
                
                
            }
            
            
        }
        
//        MobileNet
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

