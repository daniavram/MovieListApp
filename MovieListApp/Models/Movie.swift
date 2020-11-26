//
//  Movie.swift
//  MovieListApp
//
//  Created by daniel.avram on 24/11/2020.
//

import Foundation

struct Movie {
    let id: String
    let title: String
    let description: String
    let imageUrl: URL?
    let rating: Double // 0.0 - 10.0
    let duration: TimeInterval // in minutes
    let genres: [String] // Action, Sci-Fi, etc
    let releasedDate: Date
    let trailerUrl: URL?
}

extension Movie {
    
    static let none = Movie(
        id: "",
        title: "",
        description: "",
        imageUrl: nil,
        rating: 0,
        duration: 0,
        genres: [],
        releasedDate: Date(),
        trailerUrl: nil
    )
    
}
