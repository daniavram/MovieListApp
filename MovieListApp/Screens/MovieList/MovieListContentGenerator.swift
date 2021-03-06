//
//  MovieListContentGenerator.swift
//  MovieListApp
//
//  Created by daniel.avram on 24/11/2020.
//

import UIKit

class MovieListContentGenerator {

    enum SortType {
        case title
        case releaseDate
    }

    func generateTitle() -> String {
        return .titleMoviesList
    }

    func generateRightBarButtonTitle() -> String {
        return .buttonTitleSort
    }

    func generateCellContent(for movie: Movie, userInfo: UserInfo) -> MovieListCell.Content {
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
        return MovieListCell.Content(
            id: movie.id,
            image: cellImage,
            title: formattedTitle(for: movie),
            subtitle: formattedSubtitle(for: movie),
            tag: String.tagOnWatchlist.uppercased(),
            isOnWatchlist: userInfo.watchlistMoviesIds.contains(movie.id)
        )
    }

    func generateCellContents(
        for movies: [Movie],
        userInfo: UserInfo,
        sortType: SortType
    ) -> [MovieListCell.Content] {
        let sortCriteria: ((Movie, Movie) -> Bool) = {
            switch sortType {
            case .title:
                return { $0.title > $1.title }
            case .releaseDate:
                return { $0.releasedDate < $1.releasedDate }
            }
        }()
        return movies
            .sorted(by: sortCriteria)
            .map { generateCellContent(for: $0, userInfo: userInfo) }
    }

    private func formattedTitle(for movie: Movie) -> String {
        if let year = formattedYear(for: movie.releasedDate) {
            return "\(movie.title) (\(year))"
        } else {
            return movie.title
        }
    }

    private func formattedSubtitle(for movie: Movie) -> String {
        let duration = formattedDuration(for: movie.duration)
        let genres = formattedGenres(for: movie.genres)
        switch (duration, genres) {
        case ("", ""):
            return ""
        case ("", _):
            return genres
        case (_, ""):
            return duration
        default:
            return "\(duration) - \(genres)"
        }
    }

    private func formattedYear(for date: Date) -> Int? {
        let year = Calendar
            .current
            .dateComponents([.year], from: date)
            .year
        return year
    }

    private func formattedDuration(for minutes: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .short
        let formatted = formatter.string(from: minutes * 60) ?? ""
        return formatted
    }

    private func formattedGenres(for genres: [String]) -> String {
        let formatted = genres.joined(separator: ", ")
        return formatted
    }

}
