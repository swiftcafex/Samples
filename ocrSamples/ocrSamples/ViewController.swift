//
//  ViewController.swift
//  ocrSamples
//
//  Created by marspro on 2017/12/19.
//  Copyright © 2017年 dropletapps. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController {

    var imageView: UIImageView?
    var textView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelTitle = UILabel(frame: CGRect(x: 20, y: 40, width: self.view.frame.size.width, height: 30))
        labelTitle.text = "图片"
        self.view.addSubview(labelTitle)
        
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: self.view.frame.size.width * 0.7))
        self.imageView?.image = UIImage(named: "textimg")
        self.view.addSubview(self.imageView!)
        
        let labelResult = UILabel(frame: CGRect(x: 20, y: self.imageView!.frame.origin.y + self.imageView!.frame.size.height + 20, width: self.view.frame.size.width, height: 30))
        labelResult.text = "识别结果"
        self.view.addSubview(labelResult)
        
        self.textView = UITextView(frame: CGRect(x: 0, y: labelResult.frame.origin.y + labelResult.frame.size.height + 20, width: self.view.frame.size.width, height: 200))
        self.textView?.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(self.textView!)
        
        recognizeText(image: self.imageView!.image!)
        
    }
    
    func recognizeText(image: UIImage) {
        
        if let tesseract = G8Tesseract(language: "chi_sim") {
            // 2
            tesseract.engineMode = .cubeOnly
            // 3
            tesseract.pageSegmentationMode = .auto
            // 4
            tesseract.image = image
            // 5
            tesseract.recognize()
            // 6
            self.textView?.text = tesseract.recognizedText
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIImage {
    func scaleImage(_ maxDimension: CGFloat) -> UIImage? {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        
        if size.width > size.height {
            let scaleFactor = size.height / size.width
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            let scaleFactor = size.width / size.height
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}

