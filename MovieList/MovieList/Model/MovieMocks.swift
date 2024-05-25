//
//  MovieMocks.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import Foundation

struct MockData {
    
    func createMockMovie() -> Movie {
        return Movie(
            adult: false,
            backdropPath: "/sR0SpCrXamlIkYMdfz83sFn5JS6.jpg",
            genreIds: [878, 28, 12],
            id: 823464,
            originalLanguage: "en",
            originalTitle: "Godzilla x Kong: The New Empire",
            overview: "Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.",
            popularity: 4500.758,
            posterPath: "/z1p34vh7dEOnLDmyCrlUVLuoDzd.jpg",
            releaseDate: "2024-03-27",
            title: "Godzilla x Kong: The New Empire",
            video: false,
            voteAverage: 7.248,
            voteCount: 2019
        )
    }

    func createMockMovieResponse() -> MovieResponse {
        let mockMovies = [createMockMovie(), createMockMovie()]
        return MovieResponse(
            page: 1,
            results: mockMovies,
            totalPages: 44318,
            totalResults: 886353
        )
    }
}
