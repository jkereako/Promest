//
//  AppCoordinator.swift
//  Promest
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Networking

protocol AppCoordinatorDelegate: class {
    func didBuildViewModel(_ symbols: [Symbol])
}

final class AppCoordinator: Coordinatable {
    typealias Presenter = SymbolsPresenter
    typealias ViewController = SymbolsTableViewController

    let presenter: Presenter
    let viewController: ViewController

    weak var delegate: AppCoordinatorDelegate?

    init(window: UIWindow) {
        let client = RESTClient(urlSession: URLSession.shared)
        viewController = ViewController()
        presenter = Presenter(
            interactor: Presenter.Interactor(client: client)
        )

        // Wire components together
        presenter.coordinatorDelegate = self
        viewController.delegate = presenter

        // Set root view
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

    func start() {
        presenter.buildViewModel()
    }

    deinit {
        let url = URL(fileURLWithPath: #file)
        print("Deinit \(url.lastPathComponent)")
    }
}

extension AppCoordinator: AppCoordinatorDelegate {
    func didBuildViewModel(_ symbols: [Symbol]) {
        viewController.viewModel = symbols
    }
}
