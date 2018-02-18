//
//  Symbol.swift
//  Contracts
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation

struct Symbol: Codable {
    let symbol: String
    let name: String
    let date: String
    let isEnabled: Bool
    let type: String
    let iexId: String
}
