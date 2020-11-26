//
//  MovieDetailsContentGenerator.swift
//  MovieListApp
//
//  Created by daniel.avram on 26/11/2020.
//

import UIKit

class MovieDetailsContentGenerator {

    func generateHeaderContent(for movie: Movie, userInfo: UserInfo) -> MovieDetailsHeaderCell.Content {
        let cellImage: UIImage = {
            guard
                let url = movie.imageUrl,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
            else {
                return UIImage()
            }
            return image
        }()
        let rating: String? = {
            guard 0 ... 10 ~= movie.rating else { return nil }
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 1
            formatter.maximumFractionDigits = 1
            formatter.numberStyle = .decimal
            return formatter.string(from: NSNumber(value: movie.rating))
        }()
        let watchlistState: AddToWatchlistButton.WatchlistState = {
            if userInfo.watchlistMoviesIds.contains(movie.id) {
                return .added
            } else {
                return .removed
            }
        }()
        let isTrailerButtonHidden: Bool = {
            guard
                let url = movie.trailerUrl
            else {
                return true
            }
            return UIApplication.shared.canOpenURL(url) == false
        }()
        return MovieDetailsHeaderCell.Content(
            title: movie.title,
            image: cellImage,
            rating: rating,
            watchlistState: watchlistState,
            isTrailerButtonHidden: isTrailerButtonHidden
        )
    }

    func generateWatchlistState(for movie: Movie, userInfo: UserInfo) -> AddToWatchlistButton.WatchlistState {
        if userInfo.watchlistMoviesIds.contains(movie.id) {
            return .removed
        } else {
            return .added
        }
    }

    func generateDescriptionContent(for movie: Movie) -> MovieDetailsDescriptionCell.Content {
        return MovieDetailsDescriptionCell.Content(
            title: .sectionTitleMovieShortDescription,
            content: movie.description
        )
    }

    func generateDetailsContent(for movie: Movie) -> MovieDetailsDetailsCell.Content {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy, d MMMM"
        return MovieDetailsDetailsCell.Content(
            title: .sectionTitleMovieDetails,
            genreTitle: .sectionItemGenre,
            genreContent: movie.genres.joined(separator: ", "),
            releaseDateTitle: .sectionItemReleaseDate,
            releaseDateContent: formatter.string(from: movie.releasedDate)
        )
    }

}
