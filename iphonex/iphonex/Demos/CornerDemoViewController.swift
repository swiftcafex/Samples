//
//  CornerDemoViewController.swift
//  iphonex
//
//  Created by cafe on 2017/11/25.
//  Copyright © 2017年 swiftcafe. All rights reserved.
//

import UIKit

class CornerDemoViewController: UIViewController {

    var bottomView: UIView?
    var useSafeArea = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        var bottomViewFrame = CGRect.zero
        
//        if accountBottomBar {
//
//            let bottomBarHeight = CGFloat(34)
//            bottomViewFrame = CGRect(x: 0, y: self.view.frame.size.height - 50 - bottomBarHeight, width: self.view.frame.size.width, height: 50 + bottomBarHeight)
//
//        } else {
//
            bottomViewFrame = CGRect(x: 0, y: self.view.frame.size.height - 50, width: self.view.frame.size.width, height: 50)
            
//        }
        
        let bottomView = UIView(frame: bottomViewFrame)
        bottomView.backgroundColor = UIColor.black
        self.view.addSubview(bottomView)
        
        
        let btnBack = UIButton(frame: CGRect(x: 5, y: 5, width: 80, height: 40))
        btnBack.backgroundColor = UIColor.red
        btnBack.setTitle("返回", for: .normal)
        btnBack.addTarget(self, action: #selector(goback), for: UIControlEvents.touchUpInside)
        bottomView.addSubview(btnBack)
        
        self.bottomView = bottomView
        
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        if useSafeArea {
            
            let safeInset = self.view.safeAreaInsets
            
            self.bottomView?.frame = CGRect(x: 0, y: self.view.frame.size.height - 50 - safeInset.bottom, width: self.view.frame.size.width, height: 50 + safeInset.bottom)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func goback() {
        
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
