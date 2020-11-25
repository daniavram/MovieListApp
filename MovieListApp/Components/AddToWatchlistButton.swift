//
//  AddToWatchlistButton.swift
//  MovieListApp
//
//  Created by daniel.avram on 25/11/2020.
//

import UIKit

class AddToWatchlistButton: RoundedButton {

    enum WatchlistState {
        case added
        case removed
    }

    private(set) var watchlistState: WatchlistState = .added

    override func awakeFromNib() {
        super.awakeFromNib()
        adjustsImageWhenHighlighted = false
        backgroundColor = .systemGray5
        titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        tintColor = .systemGray
        imageView?.contentMode = .scaleAspectFit
        setTitleColor(.systemGray, for: .normal)
        contentEdgeInsets.left = 6
        contentEdgeInsets.right = 6
        set(state: .added)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let imageVerticalInset = 0.35 * bounds.height
        imageEdgeInsets = UIEdgeInsets(
            top: imageVerticalInset,
            left: 0,
            bottom: imageVerticalInset,
            right: 0
        )
    }

    func set(state: WatchlistState) {
        watchlistState = state
        switch state {
        case .added:
            setTitle(String.buttonTitleAddToWatchlist.uppercased(), for: .normal)
            setImage(
                UIImage(
                    systemName: "plus",
                    withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
                ),
                for: .normal
            )
        case .removed:
            setTitle(String.buttonTitleRemoveFromWatchlist.uppercased(), for: .normal)
            setImage(nil, for: .normal)
        }
    }

}
