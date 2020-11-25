//
//  MovieDetailsHeaderCell.swift
//  MovieListApp
//
//  Created by daniel.avram on 25/11/2020.
//

import UIKit

class MovieDetailsHeaderCell: UITableViewCell {

    @IBOutlet private var posterView: UIImageView!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var addToWatchlistButton: AddToWatchlistButton!
    @IBOutlet private var watchTrailer: WatchTrailerButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buttonTapAddToWatchlist(_: Any) {
        switch addToWatchlistButton.watchlistState {
        case .added:
            addToWatchlistButton.set(state: .removed)
        case .removed:
            addToWatchlistButton.set(state: .added)
        }
    }

    @IBAction func buttonTapWatchTrailer(_: Any) {}

}
