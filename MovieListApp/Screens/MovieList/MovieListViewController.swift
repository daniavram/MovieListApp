//
//  MovieListViewController.swift
//  MovieListApp
//
//  Created by daniel.avram on 23/11/2020.
//

import UIKit

class MovieListViewController: UIViewController {

    let contentGenerator: MovieListContentGenerator
    let movieManager: MovieManagerProtocol
    let userInfoManager: UserInfoManager

    private var cellContents: [MovieListCell.Content] = []

    let tableView = UITableView(frame: .zero, style: .grouped)
    var dataSource: UITableViewDiffableDataSource<Int, MovieListCell.Content>!

    init(
        contentGenerator: MovieListContentGenerator = MovieListContentGenerator(),
        movieManager: MovieManagerProtocol = LocalMovieManager(),
        userInfoManager: UserInfoManager = LocalUserInfoManager()
    ) {
        self.contentGenerator = contentGenerator
        self.movieManager = movieManager
        self.userInfoManager = userInfoManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        contentGenerator = MovieListContentGenerator()
        movieManager = LocalMovieManager()
        userInfoManager = LocalUserInfoManager()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPage
        setupNavBar()
        setupTableView()
        refreshItems(with: .title)
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

    private func setupTableView() {
        tableView.register(
            UINib(nibName: "MovieListCell", bundle: nil),
            forCellReuseIdentifier: "MovieListCell"
        )
        dataSource = UITableViewDiffableDataSource<Int, MovieListCell.Content>(
            tableView: tableView,
            cellProvider: { (table, index, _) -> UITableViewCell? in
                let cell = table.dequeueReusableCell(
                    withIdentifier: "MovieListCell",
                    for: index
                ) as? MovieListCell
                if let content = self.cellContents.element(at: index.row) {
                    cell?.update(content: content)
                }
                return cell
            }
        )
        tableView.dataSource = dataSource
        tableView.backgroundColor = .backgroundPage
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.pinToSafeArea(of: view)
    }

    private func generateSnapshot() {
        var snap = NSDiffableDataSourceSnapshot<Int, MovieListCell.Content>()
        snap.appendSections([0])
        snap.appendItems(cellContents, toSection: 0)
        dataSource.apply(snap, animatingDifferences: true, completion: nil)
    }

    private func refreshItems(with sortType: MovieListContentGenerator.SortType) {
        // TODO:
        movieManager.fetchAll(
            completion: { result in
                switch result {
                case .success(let movies):
//                    if let id = movies.element(at: 3)?.id {
//                        if self.userInfoManager.userInfo.watchlistMoviesIds.contains(id) {
//                            self.userInfoManager.storeUserInfo(UserInfo(watchlistMoviesIds: [])) { _ in }
//                        } else {
//                            self.userInfoManager.storeUserInfo(UserInfo(watchlistMoviesIds: [id])) { _ in }
//                        }
//                    }
                    self.cellContents = self.contentGenerator.generateCellContents(
                        for: movies,
                        userInfo: self.userInfoManager.userInfo,
                        sortType: sortType
                    )
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.generateSnapshot()
            }
        )
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
