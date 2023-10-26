//
//  ViewController.swift
//  KeyPathUIKit
//
//  Created by Nikolai Baklanov on 25.10.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!

    private var data: [ModelCharacter] = []
    private let configurator = CellConfigurator<ModelCharacter>(
        namePath: \ModelCharacter.name,
        urlPath: \ModelCharacter.image!
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            let result = try? await CharactersAPI.getAllCharacters(page: 1)
            if let peoples = result?.results {
                self.data = peoples
                table.reloadData()
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "Cell") as! PeopleCell
        configurator.configure(cell: cell, model: data[indexPath.row])

        return cell
    }

}

