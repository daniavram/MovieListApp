//
//  MovieListCell.swift
//  MovieListApp
//
//  Created by daniel.avram on 24/11/2020.
//

import UIKit

class MovieListCell: UITableViewCell {

    struct Content: Hashable, Equatable {

        let id: String
        let image: UIImage
        let title: String
        let subtitle: String
        let tag: String
        let isOnWatchlist: Bool

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(isOnWatchlist)
        }

        static func == (lhs: Content, rhs: Content) -> Bool {
            return lhs.id == rhs.id
                && lhs.isOnWatchlist == rhs.isOnWatchlist
        }

    }

    @IBOutlet private var posterView: ShadowedImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var tagLabel: UILabel!
    @IBOutlet private var separator: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.set(textStyle: .listCellTitle)
        subtitleLabel.set(textStyle: .listCellSubtitle)
        tagLabel.set(textStyle: .listCellTag)
        separator.backgroundColor = .separator
    }

    func update(content: Content) {
        posterView.image = content.image
        titleLabel.text = content.title
        subtitleLabel.text = content.subtitle
        tagLabel.text = content.tag
        tagLabel.isHidden = content.isOnWatchlist == false
    }

}
