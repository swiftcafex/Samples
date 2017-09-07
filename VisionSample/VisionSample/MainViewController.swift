//
//  MainViewController.swift
//  VisionSample
//
//  Created by cafe on 2017/9/6.
//  Copyright © 2017年 cafe. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?
    var menus: [(String, () -> Void)]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Vision 示例"
        
        self.tableView = UITableView(frame: self.view.bounds)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        self.menus = [
            
            ("图片人脸识别", {
                
                let viewController = ViewController()
                self.navigationController?.pushViewController(viewController, animated: true)
                
            })
            
        ]
        
    }
    
    // MARK: UITableView Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.menus?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let item = self.menus?[indexPath.row] {
        
            cell.textLabel?.text = item.0
            cell.accessoryType = .disclosureIndicator
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = self.menus?[indexPath.row] {
            
            item.1()
            
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
}
