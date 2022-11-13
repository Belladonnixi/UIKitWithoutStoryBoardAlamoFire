//
//  Project: CodingChallenge#2
//  Data.swift
//
//
//  Created by Jessica Ernst on 11.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import Foundation
import UIKit

struct FakeApiData: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    var cachedImage: UIImage?
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case albumId, id, title, url, thumbnailUrl
    }
}
