//
//  ViewController.swift
//  iphonex
//
//  Created by marspro on 2017/11/25.
//  Copyright © 2017年 swiftcafe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?

    var tableItems: [(String, String, () -> UIViewController)] = [
        ("状态栏", "假设高度为 20pt， iPhone X 适配失败， 其他 iPhone 正常。", {
            
            return Demo1ViewController()
            
            
        }),
        ("状态栏", "动态获取高度， iPhone X 可以适配。", {
            
            let vc = Demo1ViewController()
            vc.dynamicStatusHeight = true
            return vc
            
        }),
        ("状态栏", "使用 Safe Area, iPhone X 可以适配。", {
            
            let vc = Demo1ViewController()
            vc.useSafeArea = true
            return vc
            
        }),
        ("Home 条", "APP 组件与 Home 条重叠，iPhone X 适配失败， 其他 iPhone 正常。", {
            
            let vc = HomeBarDemoViewController()            
            return vc
            
        }),
        ("Home 条", "将底部 Home 区域预留出来，适配 iPhone X 成功， 但在其他 iPhone 上失败。", {
            
            let vc = HomeBarDemoViewController()
            vc.accountBottomBar = true
            return vc
            
        }),
        ("Home 条", "使用 Safe Area， 完美适配多个设备。", {
            
            let vc = HomeBarDemoViewController()
            vc.useSafeArea = true
            return vc
            
        }),
        ("圆角区域", "按钮如果不考虑到这个因素，会导致布局错乱。", {
            
            let vc = CornerDemoViewController()
//            vc.accountBottomBar = true
            return vc
            
        }),
        ("圆角区域", "使用 Safe Area, 完美适配所有 iPhone", {
            
            let vc = CornerDemoViewController()
            vc.useSafeArea = true
            return vc
            
        })
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "iPhone X 适配演示"
        
        let tableView = UITableView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        self.tableView = tableView
        
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        self.tableView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }

    // MARK: UITableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if cell == nil {
            
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            
        }
        
        cell?.textLabel?.text = tableItems[indexPath.row].0
        cell?.detailTextLabel?.text = tableItems[indexPath.row].1
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = self.tableItems[indexPath.row].2()
        vc.title = self.tableItems[indexPath.row].0
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let nav = self.navigationController {
            
            tableItems[indexPath.row].1(nav, tableItems[indexPath.row].0)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }

}

