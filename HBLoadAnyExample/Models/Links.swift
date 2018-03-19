//
//  Links.swift
//  HBLoadAnyExample
//
//  Created by Harshal Bhavsar on 18/03/18.
//  Copyright © 2018 Harshal Bhavsar. All rights reserved.
//

import Foundation

struct Links: Codable {
    let selfURL: URL?
    let html: URL?
    let download: URL?
    
    private enum CodingKeys: String, CodingKey {
        case html,download
        case selfURL = "self"
    }
}
