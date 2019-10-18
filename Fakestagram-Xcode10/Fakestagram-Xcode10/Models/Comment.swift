//
//  Comment.swift
//  Fakestagram-Xcode10
//
//  Created by Pedro Carlos Monzalvo Navarro on 17/10/19.
//  Copyright © 2019 unam. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let content: String
    let author: Author?
}

