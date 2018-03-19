//
//  UserLinks.swift
//  HBLoadAnyExample
//
//  Created by Harshal Bhavsar on 18/03/18.
//  Copyright © 2018 Harshal Bhavsar. All rights reserved.
//

import Foundation

struct UserLinks: Codable {
    let selfURL: URL?
    let photos: URL?
    let html: URL?
    let likes: URL?
    
    private enum CodingKeys: String, CodingKey {
        case html,photos,likes
        case selfURL = "self"
    }
}
