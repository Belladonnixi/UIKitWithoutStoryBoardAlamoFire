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
    var favoritesList: [FakeApiData] {
        return self.dataList.filter( { $0.isFavorite } )
    }
    var favButtonTapped: Bool = false
    
    
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func loadView() {
        super.loadView()
        
        self.title = "CC Api Call"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(showFavs))
        
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

    @objc func showFavs() {
        favButtonTapped = !favButtonTapped
        
        if favButtonTapped {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(showFavs))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(showFavs))
        }
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favButtonTapped ? favoritesList.count : dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data = favButtonTapped ? favoritesList[indexPath.row] : dataList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = data.title
        content.secondaryText = data.url
        
        if let image = data.cachedImage {
            content.image = image
        } else {
            AF.request(data.thumbnailUrl).response { response in
                switch response.result {
                case .success(let data):
                    let image = UIImage(data: data!)
                    self.dataList[indexPath.row].cachedImage = image
                    tableView.reloadRows(at: [indexPath], with: .none)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.masterVC = self
        if favButtonTapped {
            vc.selectedIndex = dataList.firstIndex(where: { $0.id == favoritesList[indexPath.row].id })
        } else {
            vc.selectedIndex = indexPath.row
        }
        navigationController?.pushViewController(vc, animated: true)
        
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
