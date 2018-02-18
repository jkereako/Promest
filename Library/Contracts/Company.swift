//
//  Company.swift
//  Contracts
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation

struct Company: Codable {
    let symbol: String
    let companyName: String
    let exchange: String
    let industry: String
    let website: String
    let description: String
    //    let ceo: String
    let issueType: String
    let sector: String
}
