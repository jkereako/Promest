//
//  PresenterType.swift
//  Promest
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import Foundation

/// Convenience base class for presenters
protocol PresenterType {
    associatedtype Interactor
    associatedtype CoordinatorDelegate

    var coordinatorDelegate: CoordinatorDelegate? { get }
    var interactor: Interactor { get }

    init(interactor: Interactor)

    func buildViewModel()
}
