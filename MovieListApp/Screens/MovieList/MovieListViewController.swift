//
//  MovieListViewController.swift
//  MovieListApp
//
//  Created by daniel.avram on 23/11/2020.
//

import UIKit

class MovieListViewController: UITableViewController {

    let contentGenerator: MovieListContentGenerator
    let movieManager: MovieManagerProtocol
    let userInfoManager: UserInfoManager

    private var dataSource: UITableViewDiffableDataSource<Int, MovieListCell.Content>!
    private var movies: [Movie] = []
    private var cellContents: [MovieListCell.Content] = []
    private var sortType: MovieListContentGenerator.SortType = .title

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
        refreshItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshItems()
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
        tableView.backgroundColor = .backgroundPage
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(
            UINib(nibName: "MovieListCell", bundle: nil),
            forCellReuseIdentifier: "MovieListCell"
        )
        dataSource = UITableViewDiffableDataSource<Int, MovieListCell.Content>(
            tableView: tableView,
            cellProvider: { (table, index, content) -> UITableViewCell? in
                let cell = table.dequeueReusableCell(
                    withIdentifier: "MovieListCell",
                    for: index
                ) as? MovieListCell
                cell?.update(content: content)
                return cell
            }
        )
        tableView.dataSource = dataSource
        tableView.delegate = self
    }

    private func generateSnapshot(animatingDifferences: Bool) {
        var snap = NSDiffableDataSourceSnapshot<Int, MovieListCell.Content>()
        snap.appendSections([0])
        snap.appendItems(cellContents, toSection: 0)
        dataSource.apply(snap, animatingDifferences: animatingDifferences, completion: nil)
    }

    private func orderCellContents(animatingDifferences: Bool) {
        cellContents = contentGenerator.generateCellContents(
            for: movies,
            userInfo: userInfoManager.userInfo,
            sortType: sortType
        )
        generateSnapshot(animatingDifferences: animatingDifferences)
    }

    private func refreshItems() {
        movieManager.fetchAll(
            completion: { result in
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.orderCellContents(animatingDifferences: false)
                case .failure(let error):
                    print(error.localizedDescription)
                }
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
                    self.sortType = .title
                    self.orderCellContents(animatingDifferences: true)
                }
            )
        )
        sheet.addAction(
            UIAlertAction(
                title: .sheetItemSortByReleaseDate,
                style: .default,
                handler: { _ in
                    self.sortType = .releaseDate
                    self.orderCellContents(animatingDifferences: true)
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

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let movieId = cellContents.element(at: indexPath.row)?.id,
            let movie = movies.first(where: { $0.id == movieId })
        else {
            return
        }
        let details = MovieDetailsViewController(
            movie: movie,
            userInfoManager: userInfoManager
        )
        navigationController?.pushViewController(details, animated: true)
    }

}
