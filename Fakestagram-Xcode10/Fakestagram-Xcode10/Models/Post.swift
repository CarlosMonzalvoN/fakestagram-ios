//
//  File.swift
//  Fakestagram-Xcode10
//
//  Created by Pedro Carlos Monzalvo Navarro on 11/10/19.
//  Copyright © 2019 unam. All rights reserved.
//

import Foundation
import UIKit

struct Post: Codable {
    let id: Int?
    let title: String
    let imageUrl: String?
    var likesCount: Int
    var commentsCount: Int
    let createdAt: String
    var liked: Bool
    let location: String
    let author: Author?
    var comments: [CommentServiceResponse]? = []
    
    func likesCountText() -> String {
        return "\(likesCount) likes"
    }
    
    func commentsCountText() -> String {
        return "\(commentsCount) comments"
    }
    
    func load(_ image: @escaping (UIImage) -> Void) {
        guard let urlString = imageUrl, let url = URL(string: urlString) else { return }
        let filename = CheckSum.sha256String(urlString)!
        if let img = ImageStore.cache.read(filename) {
            print("Reading cache")
            image(img)
            return
        }
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                print("Loading from the internet")
                _ = ImageStore.cache.write(filename, image: img)
                DispatchQueue.main.async { image(img) }
            }
        }
    }
}
