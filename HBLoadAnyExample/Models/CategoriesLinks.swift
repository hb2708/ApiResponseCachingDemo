//
//  CategoriesLinks.swift
//  HBLoadAnyExample
//
//  Created by Harshal Bhavsar on 18/03/18.
//  Copyright © 2018 Harshal Bhavsar. All rights reserved.
//

import Foundation

struct CategoriesLinks: Codable {
    let selfURL: URL?
    let photos: URL?
    
    private enum CodingKeys: String, CodingKey {
        case photos
        case selfURL = "self"
    }
}
