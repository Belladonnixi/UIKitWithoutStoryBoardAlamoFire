//
//  Project: CodingChallenge#2
//  DetailViewController.swift
//
//
//  Created by Jessica Ernst on 11.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import UIKit

class DetailViewController: UIViewController {
    
    var data: FakeApiData?
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .systemBackground
        
        titleLabel.text = data?.title
        view.addSubview(titleLabel)
        constraintsInit()
    }
    
    func constraintsInit() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
