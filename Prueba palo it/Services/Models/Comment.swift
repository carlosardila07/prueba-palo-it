//
//  Comment.swift
//  Prueba palo it
//
//  Created by Carlos Ardila on 14/03/22.
//

import Foundation

struct Comment: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
