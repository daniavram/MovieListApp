//
//  Movie.swift
//  MovieListApp
//
//  Created by daniel.avram on 24/11/2020.
//

import Foundation

struct Movie {
    let id: UUID
    let title: String
    let description: String
    let imageUrl: URL?
    let rating: Double // 0.0 - 10.0
    let duration: TimeInterval // in minutes
    let genres: [String] // Action, Sci-Fi, etc
    let releasedDate: Date
    let trailerUrl: URL?
}
