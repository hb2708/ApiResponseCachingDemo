//
//  Categories.swift
//  HBLoadAnyExample
//
//  Created by Harshal Bhavsar on 18/03/18.
//  Copyright © 2018 Harshal Bhavsar. All rights reserved.
//
import Foundation

struct Categories: Codable {
    let id: Int?
    let title: String?
    let photoCount: Int?
    let links: CategoriesLinks?
    
    private enum CodingKeys: String, CodingKey {
        case id,title,links
        case photoCount = "photo_count"
    }
}
