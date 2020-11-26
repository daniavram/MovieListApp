//
//  UITableView+Cell.swift
//  MovieListApp
//
//  Created by daniel.avram on 26/11/2020.
//

import UIKit

extension UITableView {

    func register<Cell: UITableViewCell>(nibBackedCell: Cell.Type) {
        let cellName = String(describing: nibBackedCell)
        register(
            UINib(nibName: cellName, bundle: nil),
            forCellReuseIdentifier: cellName
        )
    }

    func dequeue<Cell: UITableViewCell>(nibBackedCell: Cell.Type, for indexPath: IndexPath) -> Cell? {
        let cellName = String(describing: nibBackedCell)
        return dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? Cell
    }

}
