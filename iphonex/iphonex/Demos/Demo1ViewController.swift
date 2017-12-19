//
//  Demo1ViewController.swift
//  iphonex
//
//  Created by marspro on 2017/11/25.
//  Copyright © 2017年 swiftcafe. All rights reserved.
//

import UIKit

class Demo1ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        self.tableView = tableView
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        
        return true
        
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "text"
        return cell
        
    }
    
}
