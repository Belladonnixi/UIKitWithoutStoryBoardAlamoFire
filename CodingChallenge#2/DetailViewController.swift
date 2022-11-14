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
    var isFavorite: Bool = false
    var masterVC: ViewController!
    var selectedIndex: Int!
    
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 5
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private let favButton: UIButton = {
        let favButton = UIButton()
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favButton.configuration = .plain()
        favButton.tintColor = .systemPink
        favButton.setTitle("Favorite", for: .normal)
        return favButton
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        isFavorite = data!.isFavorite
        if isFavorite {
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .systemBackground
        data = masterVC.dataList[selectedIndex]
        titleLabel.text = data?.title
        imageView.image = data?.cachedImage
        
        favButton.addTarget(self, action: #selector(setFav), for: .touchUpInside)
        
        addSubviews()
        
        constraintsInit()
    }
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(favButton)
        view.addSubview(imageView)
    }
    
    func constraintsInit() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            favButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            favButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 50),
            favButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -50),            
            
            imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -30),
            imageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    @objc func setFav() {
        isFavorite = !isFavorite
        
        if isFavorite {
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            masterVC.dataList[selectedIndex].isFavorite = true
        } else {
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            masterVC.dataList[selectedIndex].isFavorite = false
        }
       
    }
}
