//
//  WatchTrailerButton.swift
//  MovieListApp
//
//  Created by daniel.avram on 25/11/2020.
//

import UIKit

class WatchTrailerButton: RoundedButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .backgroundPage
        layer.borderWidth = 1
        layer.borderColor = TextStyle.trailerButtonTitle.color.cgColor
        contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 14,
            bottom: 0,
            right: 14
        )
        set(textStyle: .trailerButtonTitle)
        setTitle(String.buttonTitleWatchTrailer.uppercased(), for: .normal)
    }

}
