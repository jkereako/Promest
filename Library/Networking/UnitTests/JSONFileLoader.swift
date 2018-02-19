//
//  JSONFileLoader.swift
//  NetworkingTests
//
//  Created by Jeff Kereakoglow on 2/18/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation

final class JSONFileLoader {
    let fileName: String

    init(fileName: String) {
        self.fileName = fileName
    }

    func load() -> Data {
        let bundle = Bundle(for: JSONFileLoader.self)

        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            fatalError("Unable to find \"\(fileName).json\".")
        }

        return try! Data(
            contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe
        )
    }
}
