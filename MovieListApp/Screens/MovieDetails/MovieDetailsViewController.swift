//
//  MovieDetailsViewController.swift
//  MovieListApp
//
//  Created by daniel.avram on 25/11/2020.
//

import UIKit

class MovieDetailsViewController: UITableViewController {

    private lazy var headerCell: MovieDetailsHeaderCell = {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieDetailsHeaderCell",
            for: IndexPath(row: 0, section: 0)
        ) as! MovieDetailsHeaderCell
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
            return headerCell
        case 1:
            return descriptionCell
        case 2:
            return detailsCell
        default:
            return UITableViewCell()
        }
    }

}
