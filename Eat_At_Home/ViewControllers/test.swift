//
//  test.swift
//  Eat_At_Home
//
//  Created by Phoenix McKnight on 7/2/20.
//  Copyright © 2020 Phoenix McKnight. All rights reserved.
//


import UIKit

class TableViewAdapter<T>: NSObject, UITableViewDataSource, UITableViewDelegate {

    typealias CellFactory = (UITableView, IndexPath, T) -> UITableViewCell

    var cellFactory: CellFactory!
    var didSelectItem: ((T) -> Void)?


    var data: [T] = []

    func update(with data: [T]) {
        self.data = data
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = data[indexPath.row]
        return cellFactory(tableView, indexPath, cellData)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = data[indexPath.row]
        didSelectItem?(cellData)
    }
}

