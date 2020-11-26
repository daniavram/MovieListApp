//
//  MovieDetailsDescriptionCell.swift
//  MovieListApp
//
//  Created by daniel.avram on 25/11/2020.
//

import UIKit

class MovieDetailsDescriptionCell: UITableViewCell {

    struct Content {
        let title: String
        let content: String
    }

    @IBOutlet private var topSeparator: UIView!
    @IBOutlet private var headerLabel: UILabel!
    @IBOutlet private var contentLabel: UILabel!
    @IBOutlet private var bottomSeparator: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        topSeparator.backgroundColor = .separator
        bottomSeparator.backgroundColor = .separator
        headerLabel.set(textStyle: .detailsSectionTitle)
        contentLabel.set(textStyle: .detailsSectionContent)
    }

    func update(content: Content) {
        headerLabel.text = content.title
        contentLabel.text = content.content
    }

}
