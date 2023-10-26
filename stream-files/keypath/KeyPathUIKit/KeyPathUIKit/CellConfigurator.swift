//
//  CellConfigurator.swift
//  KeyPathUIKit
//
//  Created by Nikolai Baklanov on 26.10.2023.
//

import Foundation

class CellConfigurator<Model> {
    private let namePath: KeyPath<Model, String>
    private let urlPath: KeyPath<Model, String>

    init(namePath: KeyPath<Model, String>, urlPath: KeyPath<Model, String>) {
        self.namePath = namePath
        self.urlPath = urlPath
    }

    func configure(cell: PeopleCell, model: Model) {
        cell.nameLabel.text = model[keyPath: namePath]
        cell.avatar.load(url: URL(string: model[keyPath: urlPath])!)
    }
}
