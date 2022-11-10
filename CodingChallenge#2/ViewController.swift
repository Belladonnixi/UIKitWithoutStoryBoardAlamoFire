//
//  Project: CodingChallenge#2
//  ViewController.swift
//
//
//  Created by Jessica Ernst on 10.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

