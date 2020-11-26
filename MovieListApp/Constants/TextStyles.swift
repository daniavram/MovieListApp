//
//  TextStyles.swift
//  MovieListApp
//
//  Created by daniel.avram on 25/11/2020.
//

import UIKit

extension TextStyle {

    static let detailsMovieTitle = TextStyle(
        font: UIFont.systemFont(ofSize: 18, weight: .bold),
        color: .textDark
    )
    static let detailsRatingPrimary = TextStyle(
        font: UIFont.systemFont(ofSize: 18, weight: .bold),
        color: .textDark
    )
    static let detailsRatingSecondary = TextStyle(
        font: UIFont.systemFont(ofSize: 15, weight: .regular),
        color: .textLight
    )
//    static let detailsColumnContent = TextStyle(font: <#T##UIFont#>, color: <#T##UIColor#>)
//    static let detailsColumnTitle = TextStyle(font: <#T##UIFont#>, color: <#T##UIColor#>)
//    static let detailsSectionContent = TextStyle(font: <#T##UIFont#>, color: <#T##UIColor#>)
//    static let detailsSectionTitle = TextStyle(font: <#T##UIFont#>, color: <#T##UIColor#>)
    static let listCellSubtitle = TextStyle(
        font: UIFont.systemFont(ofSize: 14, weight: .regular),
        color: .textLight
    )
    static let listCellTag = TextStyle(
        font: UIFont.systemFont(ofSize: 10, weight: .bold),
        color: .textMedium
    )
    static let listCellTitle = TextStyle(
        font: UIFont.systemFont(ofSize: 16, weight: .medium),
        color: .textDark
    )
    static let trailerButtonTitle = TextStyle(
        font: UIFont.systemFont(ofSize: 10, weight: .bold),
        color: .textDark
    )
    static let watchlistButtonTitle = TextStyle(
        font: UIFont.systemFont(ofSize: 10, weight: .bold),
        color: .systemGray
    )

}
