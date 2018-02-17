//
//  AppDelegate.swift
//  Pusher
//
//  Created by Jeff Kereakoglow on 2/15/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit
import Promises

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

enum IEX {
    case company(companyName: String)
    case financials(companyName: String, queryItems: [URLQueryItem])
}

extension IEX: Endpoint {
    var baseURL: URL { return URL(string: "https://api.iextrading.com/1.0")! }
    var path: String {
        switch self {
        case .company(let companyName):
            return "/stock/\(companyName)/company"
        case .financials(let companyName, let queryItems):

            let path = "/stock/\(companyName)/financials"

            return buildPath(path, appendingQueryItems: queryItems)
        }
    }
}

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        let queryItems = [
            URLQueryItem(name: "version", value: "3.14.2"),
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "q", value: "Test test 123")
        ]

        print(IEX.financials(companyName: "aapl", queryItems: queryItems).path)

        let client = RESTClient(urlSession: URLSession.shared)

        client.get(endpoint: IEX.company(companyName: "aapl"), decodable: Company.self).then { company in
            print(company.companyName)
        }
    }
}
