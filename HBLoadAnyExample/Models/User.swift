//
//  User.swift
//  HBLoadAnyExample
//
//  Created by Harshal Bhavsar on 18/03/18.
//  Copyright © 2018 Harshal Bhavsar. All rights reserved.
//
import Foundation

struct User: Codable {
    let id: String?
    let username: String?
    let name: String?
    let profileImage: ProfileImage?
    let links: UserLinks?
    
    private enum CodingKeys: String, CodingKey {
        case id,username,name,links
        case profileImage = "profile_image"
    }
}
