//
//  MovieDetailsDetailsCell.swift
//  MovieListApp
//
//  Created by daniel.avram on 25/11/2020.
//

import UIKit

class MovieDetailsDetailsCell: UITableViewCell {

    struct Content {
        let title: String
        let genreTitle: String
        let genreContent: String
        let releaseDateTitle: String
        let releaseDateContent: String
    }

    @IBOutlet private var headerLabel: UILabel!
    @IBOutlet private var genreTitleLabel: UILabel!
    @IBOutlet private var genreContentLabel: UILabel!
    @IBOutlet private var releaseDateTitleLabel: UILabel!
    @IBOutlet private var releaseDateContentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        headerLabel.set(textStyle: .detailsSectionTitle)
        genreTitleLabel.set(textStyle: .detailsColumnTitle)
        genreContentLabel.set(textStyle: .detailsColumnContent)
        releaseDateTitleLabel.set(textStyle: .detailsColumnTitle)
        releaseDateContentLabel.set(textStyle: .detailsColumnContent)
    }

    func update(content: Content) {
        headerLabel.text = content.title
        genreTitleLabel.text = content.genreTitle
        genreContentLabel.text = content.genreContent
        releaseDateTitleLabel.text = content.releaseDateTitle
        releaseDateContentLabel.text = content.releaseDateContent
    }

}
