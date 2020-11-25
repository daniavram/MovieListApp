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
        let tag: String
        let isOnWatchlist: Bool

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(isOnWatchlist)
        }

    }

    @IBOutlet private var posterView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var tagLabel: UILabel!
    @IBOutlet private var separator: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .textDark
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = .textLight
        tagLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        tagLabel.textColor = .textMedium
        separator.backgroundColor = .separator
    }

    func update(content: Content) {
        if let url = content.imageUrl, let data = try? Data(contentsOf: url) {
            posterView.image = UIImage(data: data)
        }
        titleLabel.text = content.title
        subtitleLabel.text = content.subtitle
        tagLabel.text = content.tag
        tagLabel.isHidden = content.isOnWatchlist == false
    }

}
