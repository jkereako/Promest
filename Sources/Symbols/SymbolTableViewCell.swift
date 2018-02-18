//
//  SymbolTableViewCell.swift
//  Promest
//
//  Created by Jeff Kereakoglow on 2/17/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit

final class SymbolTableViewCell: UITableViewCell {
    var viewModel: Symbol! {
        didSet {
            symbol.text = viewModel.symbol
            name.text = viewModel.name
        }
    }

    @IBOutlet private weak var symbol: UILabel!
    @IBOutlet private weak var name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        symbol.text = nil
        name.text = nil
    }
}
