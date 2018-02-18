//
//  IEX.swift
//  Promest
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Networking

enum IEX {
    case symbols
    case company(companyName: String)
    case financials(companyName: String)
}

extension IEX: Endpoint {
    var baseURL: URL { return URL(string: "https://api.iextrading.com/1.0")! }
    var path: String {
        switch self {
        case .symbols:
            return "/ref-data/symbols"
        case .company(let companyName):
            return "/stock/\(companyName)/company"
        case .financials(let companyName):
            return "/stock/\(companyName)/financials"
        }
    }
}
