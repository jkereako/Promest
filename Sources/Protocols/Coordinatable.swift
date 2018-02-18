//
//  Coordinatable.swift
//  Promest
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit.UIViewController

protocol Coordinatable {
    associatedtype Presenter: PresenterType
    associatedtype ViewController: UIViewController

    var presenter: Presenter { get }
    var viewController: ViewController  { get }
}
