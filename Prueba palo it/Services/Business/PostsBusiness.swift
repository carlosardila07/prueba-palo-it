//
//  PostsBusiness.swift
//  Prueba palo it
//
//  Created by Carlos Ardila on 14/03/22.
//

import Foundation
import PromiseKit

struct PostsBusiness {
    func getPosts() -> Promise<[Post]> {
        return NetworkManager.shared.arrayRequest("posts", method: .get)
    }
    
    func getComments(postId: Int) -> Promise<[Comment]> {
        return NetworkManager.shared.arrayRequest("comments?postId=\(postId)", method: .get)
    }
}
