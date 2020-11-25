//
//  MovieListViewController.swift
//  MovieListApp
//
//  Created by daniel.avram on 23/11/2020.
//

import UIKit

class MovieListViewController: UIViewController {

    let contentGenerator: MovieListContentGenerator

    init(
        contentGenerator: MovieListContentGenerator = MovieListContentGenerator()
    ) {
        self.contentGenerator = contentGenerator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.contentGenerator = MovieListContentGenerator()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPage
        setupNavBar()
        refreshItems(with: .releaseDate)
    }

    private func setupNavBar() {
        title = contentGenerator.generateTitle()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.setRightBarButton(
            UIBarButtonItem(
                title: contentGenerator.generateRightBarButtonTitle(),
                style: .plain,
                target: self,
                action: #selector(buttonTapSort)
            ),
            animated: false
        )
    }

    private func refreshItems(with _: MovieListContentGenerator.SortType) {
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
