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
import Alamofire

class ViewController: UIViewController {
    
    var dataList: [FakeApiData] = []
    var cachedImages = [UIImage?]()
    var selectedDataset: FakeApiData?
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchFakeApiData()
    }
    
    override func loadView() {
        super.loadView()
        
        self.title = "CC Api Call"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        constraintsInit()
    }
    
    
    func constraintsInit() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data = dataList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = data.title
        content.secondaryText = data.url
        
        if self.cachedImages.indices.contains(indexPath.row) {
            content.image = self.cachedImages[indexPath.row]
        } else {
            AF.request(data.thumbnailUrl).response{ response in
                switch response.result {
                case .success(let data):
                    let image = UIImage(data: data!)
                    self.cachedImages.append(image)
                    tableView.reloadRows(at: [indexPath], with: .none)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        cell.contentConfiguration = content
        return cell
    }
    
    
}

extension ViewController {
    

    func fetchFakeApiData() {
        
        let url = "https://jsonplaceholder.typicode.com/photos"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: [FakeApiData].self) { (response) in
                guard let data = response.value else { return }
                self.dataList = data
                self.tableView.reloadData()

            }
    }
}
