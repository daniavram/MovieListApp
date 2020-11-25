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
        layer.borderColor = UIColor.textDark.cgColor
        titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 14,
            bottom: 0,
            right: 14
        )
        setTitleColor(.textDark, for: .normal)
        setTitle(String.buttonTitleWatchTrailer.uppercased(), for: .normal)
    }

}
