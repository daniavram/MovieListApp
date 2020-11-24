//
//  MovieListViewController.swift
//  MovieListApp
//
//  Created by daniel.avram on 23/11/2020.
//

import UIKit

class MovieListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPage
        setupNavBar()
        refreshItems(with: .releaseDate)
    }

    private func setupNavBar() {
        title = .titleMoviesList
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.setRightBarButton(
            UIBarButtonItem(
                title: .buttonTitleSort,
                style: .plain,
                target: self,
                action: #selector(buttonTapSort)
            ),
            animated: false
        )
    }

    private func refreshItems(with _: SortType) {
        // TODO:
    }

    @objc private func buttonTapSort() {
        let sheet = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        sheet.view.tintColor = .textLight
        sheet.addAction(
            UIAlertAction(
                title: .sheetItemSortByTitle,
                style: .default,
                handler: { _ in
                    self.refreshItems(with: .title)
                }
            )
        )
        sheet.addAction(
            UIAlertAction(
                title: .sheetItemSortByReleaseDate,
                style: .default,
                handler: { _ in
                    self.refreshItems(with: .releaseDate)
                }
            )
        )
        sheet.addAction(
            UIAlertAction(
                title: .sheetItemCancel,
                style: .cancel,
                handler: nil
            )
        )
        present(sheet, animated: true, completion: nil)
    }

}

enum SortType {
    case title
    case releaseDate
}
