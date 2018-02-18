//
//  SymbolsPresenter.swift
//  Promest
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation

final class SymbolsPresenter: PresenterType {
    typealias CoordinatorDelegate = AppCoordinatorDelegate
    typealias Interactor = SymbolsInteractor

    weak var coordinatorDelegate: CoordinatorDelegate?

    let interactor: Interactor

    init(interactor: Interactor) {
        self.interactor = interactor
    }

    func buildViewModel() {
        interactor.fetchSymbols().then { symbols in
            self.coordinatorDelegate?.didBuildViewModel(symbols)
        }
    }

    deinit {
        let url = URL(fileURLWithPath: #file)
        print("Deinit \(url.lastPathComponent)")
    }
}

// MARK: - View controller delegate
extension SymbolsPresenter: SymbolsTableViewControllerDelegate {
    func didSelectSymbol(_ symbol: Symbol) {
        print(symbol.name)
    }
}
