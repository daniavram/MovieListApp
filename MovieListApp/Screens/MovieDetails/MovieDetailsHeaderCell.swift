//
//  MovieDetailsHeaderCell.swift
//  MovieListApp
//
//  Created by daniel.avram on 25/11/2020.
//

import UIKit

protocol MovieDetailsHeaderCellDelegate: class {
    func didTapWatchlistButton(withState watchlistState: AddToWatchlistButton.WatchlistState)
    func didTapTrailerButton()
}

class MovieDetailsHeaderCell: UITableViewCell {

    struct Content {
        let title: String
        let image: UIImage
        let rating: String?
        let watchlistState: AddToWatchlistButton.WatchlistState
        let isTrailerButtonHidden: Bool
    }

    @IBOutlet private var posterView: ShadowedImageView!
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var addToWatchlistButton: AddToWatchlistButton!
    @IBOutlet private var watchTrailerButton: WatchTrailerButton!

    weak var delegate: MovieDetailsHeaderCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        movieTitleLabel.set(textStyle: .detailsMovieTitle)
    }

    func update(content: Content) {
        posterView.image = content.image
        movieTitleLabel.text = content.title
        watchTrailerButton.isHidden = content.isTrailerButtonHidden
        ratingLabel.isHidden = content.rating == nil
        if let rating = content.rating {
            let attributed = NSMutableAttributedString()
            attributed.append(
                NSAttributedString(
                    string: rating,
                    attributes: [
                        .foregroundColor: TextStyle.detailsRatingPrimary.color,
                        .font: TextStyle.detailsRatingPrimary.font,
                    ]
                )
            )
            attributed.append(
                NSAttributedString(
                    string: "/10",
                    attributes: [
                        .foregroundColor: TextStyle.detailsRatingSecondary.color,
                        .font: TextStyle.detailsRatingSecondary.font,
                    ]
                )
            )
            ratingLabel.attributedText = attributed
        }
    }

    func update(watchlistState: AddToWatchlistButton.WatchlistState) {
        addToWatchlistButton.set(state: watchlistState)
    }

    @IBAction private func buttonTapAddToWatchlist(_: Any) {
        delegate?.didTapWatchlistButton(withState: addToWatchlistButton.watchlistState)
    }

    @IBAction private func buttonTapWatchTrailer(_: Any) {
        delegate?.didTapTrailerButton()
    }

}
