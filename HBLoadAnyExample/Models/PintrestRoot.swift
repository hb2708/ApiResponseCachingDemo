//
//  RootOject.swift
//  HBLoadAnyExample
//
//  Created by Harshal Bhavsar on 18/03/18.
//  Copyright © 2018 Harshal Bhavsar. All rights reserved.
//
import Foundation

struct PintrestRoot: Codable {
    let id: String?
    let createdAt: String?
    let width: Int?
    let height: Int?
    let color: String?
    let likes: Int?
    let likedByUser: Bool?
    let user: User?
    //let currentUserCollections: Any?
    let urls: URLS?
    let categories: [Categories]?
    let links: Links?
    
    private enum CodingKeys: String, CodingKey {
        case id,width,height,color,likes,user,urls,categories,links
        case createdAt = "created_at"
        case likedByUser = "liked_by_user"
        //case currentUserCollections = "current_user_collections"
    }
}
