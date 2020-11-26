//
//  MovieDetailsViewController.swift
//  MovieListApp
//
//  Created by daniel.avram on 25/11/2020.
//

import UIKit

class MovieDetailsViewController: UITableViewController {

    let movie: Movie
    let userInfoManager: UserInfoManager
    let contentGenerator: MovieDetailsContentGenerator

    private lazy var headerCell: MovieDetailsHeaderCell = {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieDetailsHeaderCell",
            for: IndexPath(row: 0, section: 0)
        ) as! MovieDetailsHeaderCell
        cell.delegate = self
        return cell
    }()

    private lazy var descriptionCell: MovieDetailsDescriptionCell = {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieDetailsDescriptionCell",
            for: IndexPath(row: 1, section: 0)
        ) as! MovieDetailsDescriptionCell
        return cell
    }()

    private lazy var detailsCell: MovieDetailsDetailsCell = {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieDetailsDetailsCell",
            for: IndexPath(row: 2, section: 0)
        ) as! MovieDetailsDetailsCell
        return cell
    }()

    init(
        movie: Movie,
        userInfoManager: UserInfoManager,
        contentGenerator: MovieDetailsContentGenerator = MovieDetailsContentGenerator()
    ) {
        self.movie = movie
        self.userInfoManager = userInfoManager
        self.contentGenerator = contentGenerator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        movie = .none
        userInfoManager = LocalUserInfoManager()
        contentGenerator = MovieDetailsContentGenerator()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPage
        setupNavBar()
        setupTableView()
    }

    private func setupNavBar() {
        navigationItem.largeTitleDisplayMode = .never
    }

    private func setupTableView() {
        tableView.backgroundColor = .backgroundPage
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.register(
            UINib(nibName: "MovieDetailsDescriptionCell", bundle: nil),
            forCellReuseIdentifier: "MovieDetailsDescriptionCell"
        )
        tableView.register(
            UINib(nibName: "MovieDetailsDetailsCell", bundle: nil),
            forCellReuseIdentifier: "MovieDetailsDetailsCell"
        )
        tableView.register(
            UINib(nibName: "MovieDetailsHeaderCell", bundle: nil),
            forCellReuseIdentifier: "MovieDetailsHeaderCell"
        )
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 3
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            headerCell.update(
                content: contentGenerator.generateHeaderContent(
                    for: movie,
                    userInfo: userInfoManager.userInfo
                )
            )
            headerCell.update(
                watchlistState: contentGenerator.generateWatchlistState(
                    for: movie,
                    userInfo: userInfoManager.userInfo
                )
            )
            return headerCell
        case 1:
            descriptionCell.update(
                content: contentGenerator.generateDescriptionContent(
                    for: movie
                )
            )
            return descriptionCell
        case 2:
            detailsCell.update(
                content: contentGenerator.generateDetailsContent(
                    for: movie
                )
            )
            return detailsCell
        default:
            return UITableViewCell()
        }
    }

}

extension MovieDetailsViewController: MovieDetailsHeaderCellDelegate {

    func didTapWatchlistButton(withState _: AddToWatchlistButton.WatchlistState) {
        var ids = userInfoManager.userInfo.watchlistMoviesIds
        if ids.contains(movie.id) {
            ids.removeAll(where: { $0 == movie.id })
        } else {
            ids.append(movie.id)
        }
        userInfoManager.storeUserInfo(
            UserInfo(watchlistMoviesIds: ids),
            completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.headerCell.update(
                        watchlistState: self.contentGenerator.generateWatchlistState(
                            for: self.movie,
                            userInfo: self.userInfoManager.userInfo
                        )
                    )
                case .failure:
                    break
                }
            }
        )
    }

    func didTapTrailerButton() {
        guard let url = movie.trailerUrl else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}
