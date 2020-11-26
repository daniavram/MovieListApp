//
//  MovieManager.swift
//  MovieListApp
//
//  Created by daniel.avram on 24/11/2020.
//

import Foundation

protocol MovieManagerProtocol {
    func fetchAll(completion: @escaping (Result<[Movie], Error>) -> Void)
}

class LocalMovieManager: MovieManagerProtocol {

    private let page0 = [
        Movie(
            id: "tenet",
            title: "Tenet",
            description: "Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time.",
            imageUrl: Bundle.main.url(forResource: "Tenet", withExtension: "png"),
            rating: 7.8,
            duration: 150,
            genres: [
                "Action",
                "Sci-Fi",
            ],
            releasedDate: Date(timeIntervalSince1970: 1_599_004_800), // "3 September 2020",
            trailerUrl: URL(string: "https://www.youtube.com/watch?v=LdOM0x0XDMo")
        ),
        Movie(
            id: "spider_man_into_the_spider_verse",
            title: "Spider-Man: Into the Spider-Verse",
            description: "Teen Miles Morales becomes the Spider-Man of his universe, and must join with five spider-powered individuals from other dimensions to stop a threat for all realities.",
            imageUrl: Bundle.main.url(forResource: "Spider Man", withExtension: "png"),
            rating: 8.4,
            duration: 117,
            genres: [
                "Action",
                "Animation",
                "Adventure",
            ],
            releasedDate: Date(timeIntervalSince1970: 1_544_745_600), // "14 December 2018",
            trailerUrl: URL(string: "https://www.youtube.com/watch?v=tg52up16eq0")
        ),
        Movie(
            id: "knives_out",
            title: "Knives Out",
            description: "A detective investigates the death of a patriarch of an eccentric, combative family.",
            imageUrl: Bundle.main.url(forResource: "Knives Out", withExtension: "png"),
            rating: 7.9,
            duration: 130,
            genres: [
                "Comedy",
                "Crime",
                "Drama",
            ],
            releasedDate: Date(timeIntervalSince1970: 1_574_812_800), // "27 November 2019",
            trailerUrl: URL(string: "https://www.youtube.com/watch?v=qGqiHJTsRkQ")
        ),
        Movie(
            id: "guardians_of_the_galaxy",
            title: "Guardians of the Galaxy",
            description: "A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe.",
            imageUrl: Bundle.main.url(forResource: "Guardians of The Galaxy", withExtension: "png"),
            rating: 8.0,
            duration: 121,
            genres: [
                "Action",
                "Adventure",
                "Comedy",
            ],
            releasedDate: Date(timeIntervalSince1970: 1_406_851_200), // "1 August 2014",
            trailerUrl: URL(string: "https://www.youtube.com/watch?v=d96cjJhvlMA")
        ),
        Movie(
            id: "avengers_age_of_ultron",
            title: "Avengers: Age of Ultron",
            description: "When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan.",
            imageUrl: Bundle.main.url(forResource: "Avengers", withExtension: "png"),
            rating: 7.3,
            duration: 141,
            genres: [
                "Action",
                "Adventure",
                "Sci-Fi",
            ],
            releasedDate: Date(timeIntervalSince1970: 1_430_438_400), // "1 May 2015",
            trailerUrl: URL(string: "https://www.youtube.com/watch?v=tmeOjFno6Do")
        ),
    ]

    func fetchAll(completion: @escaping (Result<[Movie], Error>) -> Void) {
        completion(.success(page0))
    }

}
