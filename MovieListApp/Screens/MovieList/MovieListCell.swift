//
//  MovieListCell.swift
//  MovieListApp
//
//  Created by daniel.avram on 24/11/2020.
//

import UIKit

class MovieListCell: UITableViewCell {

    struct Content: Hashable {

        let id: UUID
        let imageUrl: URL?
        let title: String
        let subtitle: String
        let isOnWatchlist: Bool

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(isOnWatchlist)
        }

    }

}
