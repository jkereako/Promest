//
//  JSONPlaceholderEndpoint.swift
//  Promest
//
//  Created by Jeff Kereakoglow on 2/21/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//


import Networking

enum JSONPlaceholderEndpoint {
    case users(id: Int?)
    case posts(id: Int?)
    case comments(id: Int?)
    case photos(id: Int?)
    case albums(id: Int?)
    case todos(id: Int?)
}

extension JSONPlaceholderEndpoint: Endpoint {
    var baseURL: URL { return URL(string: "https://jsonplaceholder.typicode.com")! }
    var path: String {
        switch self {
        case .users(let id):
            return "/users"
        case .posts(let id):
            return "/posts"
        case .comments(let id):
            return "/comments"
        case .photos(let id):
            return "/photos"
        case .albums(let id):
            return "/albums"
        case .todos(let id):
            return "/todos"
        }
    }
}

