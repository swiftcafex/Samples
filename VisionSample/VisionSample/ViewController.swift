//
//  ViewController.swift
//  VisionSample
//
//  Created by cafe on 2017/9/6.
//  Copyright © 2017年 cafe. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imageView: UIImageView?
    var faceRects: [UIView]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "图片人脸识别"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "相册", style: .plain, target: self, action: #selector(openAlbum))
        self.reloadImage()
        
    }
    
    func reloadImage() {
        
        self.reloadImage(imageURL: nil)
        
    }
    
    func reloadImage(imageURL : URL?) {
        
        var imageToDetect: UIImage?
        
        if imageURL == nil {
            
            //如果没有指定图片， 则加载默认图
            imageToDetect = UIImage(named: "photo")
            
        } else {
            
            if let url = imageURL {
            
                imageToDetect = UIImage(contentsOfFile: url.path)
            
            }
            
            
        }
        
        if let image = imageToDetect {
            
            //如果图片加载成功，进行后续识别操作
         
            let ratio = image.size.height / image.size.width
            
            //删除上次的识别框
            self.faceRects?.map{ item in
                
                item.removeFromSuperview()
                
            }
            self.faceRects?.removeAll()
            self.imageView?.removeFromSuperview()
            
            self.imageView = UIImageView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.width * ratio))
            self.imageView?.image = image
            self.view.addSubview(self.imageView!)
            
            guard let ciImage = CIImage(image: image) else { return }
            
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: CGImagePropertyOrientation.up)
            
            let request = VNDetectFaceRectanglesRequest(completionHandler: { (request, error) in
                
                DispatchQueue.main.async {
                    
                    if let result = request.results {
                        
                        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -self.imageView!.frame.size.height)
                        let translate = CGAffineTransform.identity.scaledBy(x: self.imageView!.frame.size.width, y: self.imageView!.frame.size.height)
                        
                        for item in result {
                            
                            let faceRect = UIView(frame: CGRect.zero)
                            faceRect.backgroundColor = UIColor(red: 0, green: 1.0, blue: 0, alpha: 0.5)
                            self.faceRects?.append(faceRect)
                            self.imageView!.addSubview(faceRect)
                            
                            if let faceObservation = item as? VNFaceObservation {
                                
                                print(faceObservation.boundingBox)
                                let finalRect = faceObservation.boundingBox.applying(translate).applying(transform)
                                print(finalRect)
                                faceRect.frame = finalRect
                                
                            }
                            
                        }
                        
                    }
                }
                
                
            })
            
            
            
            DispatchQueue.global(qos: .userInteractive).async {
                
                do {
                    
                    try handler.perform([request])
                    
                } catch {
                    
                    
                    
                }
                
            }
            
        }
        
    }
    
    @objc func openAlbum() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let url = info[UIImagePickerControllerImageURL] as? URL {
        
            self.reloadImage(imageURL: url)
            
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

