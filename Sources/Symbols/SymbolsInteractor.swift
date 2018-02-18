//
//  SymbolsInteractor.swift
//  Promest
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Promises
import Networking

final class SymbolsInteractor {
    let client: IEXAPIClient

    init(client: IEXAPIClient) {
        self.client = client
    }

    deinit {
        let url = URL(fileURLWithPath: #file)
        print("Deinit \(url.lastPathComponent)")
    }
    
    func fetchSymbols() -> Promise<[Symbol]> {
        return client.get(IEX.symbols, decodeResponseTo: [Symbol].self)
    }
}
