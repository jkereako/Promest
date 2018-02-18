//
//  SymbolsTableViewController.swift
//  Promest
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit
import Contracts

protocol SymbolsTableViewControllerDelegate: class {
    func didSelectSymbol(_ symbol: Symbol)
}

final class SymbolsTableViewController: UITableViewController {
    weak var delegate: SymbolsTableViewControllerDelegate?

    var viewModel: [Symbol]? {
        didSet {
            tableView.reloadData()
        }
    }

    fileprivate let reuseIdentifier = "SymbolTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - Table view data source
extension SymbolsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel == nil ? 0 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier, for: indexPath) as? SymbolTableViewCell else {
                assertionFailure("Expected a SymbolTableViewCell")
                
                return UITableViewCell()
        }

        cell.viewModel = viewModel![indexPath.row]

        return cell
    }
}

extension SymbolsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        delegate?.didSelectSymbol(viewModel![indexPath.row])
    }
}
