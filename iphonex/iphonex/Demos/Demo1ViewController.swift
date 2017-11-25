//
//  Demo1ViewController.swift
//  iphonex
//
//  Created by marspro on 2017/11/25.
//  Copyright © 2017年 swiftcafe. All rights reserved.
//

import UIKit

class Demo1ViewController: UIViewController {
    
    var topView:UIView?
    
    //动态确定状态栏高度， 适配 iPhone X 新的状态栏高度
    var dynamicStatusHeight = false
    var useSafeArea = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        var topViewFrame = CGRect.zero
        
        if dynamicStatusHeight {
            
            //动态获取高度， 可以适配
            topViewFrame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.size.width, height: 50)
            
        } else {
            
            //写死状态栏高度， 适配错误
            topViewFrame = CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 50)
            
        }
        
        let topView = UIView(frame: topViewFrame)
        topView.backgroundColor = UIColor.black
        self.view.addSubview(topView)
        
        let btnBack = UIButton(frame: CGRect(x: 5, y: 5, width: 80, height: 40))
        btnBack.setTitle("返回", for: .normal)
        btnBack.addTarget(self, action: #selector(goback), for: UIControlEvents.touchUpInside)
        topView.addSubview(btnBack)
        
        self.topView = topView
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
    @objc func goback() {
        
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        if useSafeArea {
            
            let safeInset = self.view.safeAreaInsets
            
            let topFrame = CGRect(x: safeInset.left, y: safeInset.top, width: self.view.frame.size.width - safeInset.right, height: 50)
            self.topView?.frame = topFrame
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableView Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "列表项 \(indexPath.row)"
        
        return cell
        
    }

}
