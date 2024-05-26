//
//  MovieViewModelTests.swift
//  MovieListTests
//
//  Created by JASS on 26/05/24.
//

import XCTest
import Combine
@testable import MovieList

final class MovieViewModelTests: XCTestCase {
    
    var viewModel: MovieViewModel!
    var cancellables: Set<AnyCancellable>!
    let movieResponse = MovieMocks().createMockMovieResponse()
    
    override func setUp() {
        super.setUp()
        viewModel = MovieViewModel()
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testGetPopularMoviesSuccess() {
        
        let expectation = XCTestExpectation(description: "Movies loaded")
        
        let mockAPIService = MockAPIService()
        mockAPIService.popularMoviesResponse = movieResponse
        viewModel = MovieViewModel(apiService: mockAPIService)
        
        viewModel.$popularMovies
            .dropFirst()
            .sink { movies in
                XCTAssertEqual(movies.count, 2)
                XCTAssertEqual(movies.first?.title, "Godzilla x Kong: The New Empire")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getPopularMovies()
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetTopRatedMoviesSuccess() {
        
        let expectation = XCTestExpectation(description: "Movies loaded")
        
        let mockAPIService = MockAPIService()
        mockAPIService.topRatedMoviesResponse = movieResponse
        viewModel = MovieViewModel(apiService: mockAPIService)
        
        viewModel.$topRatedMovies
            .dropFirst()
            .sink { movies in
                XCTAssertEqual(movies.count, 2)
                XCTAssertEqual(movies.first?.title, "Godzilla x Kong: The New Empire")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getTopRatedMovies()
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSearchMoviesPopular() {
        
        let mockAPIService = MockAPIService()
        mockAPIService.popularMoviesResponse = movieResponse
        viewModel = MovieViewModel(apiService: mockAPIService)
        
        let expectation = XCTestExpectation(description: "Movies loaded")
        
        viewModel.$popularMovies
            .dropFirst()
            .sink { movies in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getPopularMovies()
        
        wait(for: [expectation], timeout: 5.0)
        
        // Search test
        viewModel.searchPopular = "Empire"
        viewModel.searchMovies(search: viewModel.searchPopular)
        
        XCTAssertEqual(viewModel.popularMovies.count, 2)
        XCTAssertEqual(viewModel.popularMovies.first?.title, "Godzilla x Kong: The New Empire")
    }
    
    func testSearchMoviesTopRated() {
        
        let mockAPIService = MockAPIService()
        mockAPIService.topRatedMoviesResponse = movieResponse
        viewModel = MovieViewModel(apiService: mockAPIService)
        
        let expectation = XCTestExpectation(description: "Movies loaded")
        
        viewModel.$topRatedMovies
            .dropFirst()
            .sink { movies in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getTopRatedMovies()
        
        wait(for: [expectation], timeout: 5.0)
        
        // Search test
        viewModel.typeSelect = .topRated
        viewModel.searchTopRated = "Empire"
        viewModel.searchMovies(search: viewModel.searchTopRated)
        
        XCTAssertEqual(viewModel.topRatedMovies.count, 2)
        XCTAssertEqual(viewModel.topRatedMovies.first?.title, "Godzilla x Kong: The New Empire")
    }
    
    func testGetFiltersPopular() {
        
        let popularMovies = [
            Movie(adult: false, backdropPath: "/path.jpg", genreIds: [12, 28], id: 123, originalLanguage: "en", originalTitle: "Movie One", overview: "Overview", popularity: 100.0, posterPath: "/poster.jpg", releaseDate: "2023-01-01", title: "Movie One", video: false, voteAverage: 8.5, voteCount: 1000),
            Movie(adult: false, backdropPath: "/path2.jpg", genreIds: [12, 28], id: 124, originalLanguage: "es", originalTitle: "Movie Two", overview: "Overview", popularity: 90.0, posterPath: "/poster2.jpg", releaseDate: "2023-02-01", title: "Movie Two", video: false, voteAverage: 7.5, voteCount: 800),
            Movie(adult: false, backdropPath: "/path3.jpg", genreIds: [12, 28], id: 125, originalLanguage: "en", originalTitle: "Movie Three", overview: "Overview", popularity: 80.0, posterPath: "/poster3.jpg", releaseDate: "2023-03-01", title: "Movie Three", video: false, voteAverage: 9.0, voteCount: 900)
        ]
        let movieResponse = MovieResponse(page: 1, results: popularMovies, totalPages: 1, totalResults: 3)
        
        viewModel.exposedPopularResponseMovies(movieResponse)
        
        viewModel.exposedGetFiltersPopular()
        
        let expectedLanguages = ["en", "es"]
        XCTAssertEqual(viewModel.filterOriginalLanguagePopular.sorted(), expectedLanguages.sorted(), "Los idiomas originales no coinciden")
        
        let expectedVoteAverages: [Double] = [8.5, 7.5, 9.0]
        XCTAssertEqual(viewModel.filterVoteAveragePopular.sorted(), expectedVoteAverages.sorted(), "Los promedios de votos no coinciden")
    }
    
    func testGetFiltersTopRated() {
        
        let topRatedMovies = [
            Movie(adult: false, backdropPath: "/path.jpg", genreIds: [12, 28], id: 123, originalLanguage: "en", originalTitle: "Movie One", overview: "Overview", popularity: 100.0, posterPath: "/poster.jpg", releaseDate: "2023-01-01", title: "Movie One", video: false, voteAverage: 8.5, voteCount: 1000),
            Movie(adult: false, backdropPath: "/path2.jpg", genreIds: [12, 28], id: 124, originalLanguage: "es", originalTitle: "Movie Two", overview: "Overview", popularity: 90.0, posterPath: "/poster2.jpg", releaseDate: "2023-02-01", title: "Movie Two", video: false, voteAverage: 7.5, voteCount: 800),
            Movie(adult: false, backdropPath: "/path3.jpg", genreIds: [12, 28], id: 125, originalLanguage: "en", originalTitle: "Movie Three", overview: "Overview", popularity: 80.0, posterPath: "/poster3.jpg", releaseDate: "2023-03-01", title: "Movie Three", video: false, voteAverage: 9.0, voteCount: 900)
        ]
        let movieResponse = MovieResponse(page: 1, results: topRatedMovies, totalPages: 1, totalResults: 3)
        
        viewModel.exposedTopRatedResponseMovies(movieResponse)
        
        viewModel.exposedGetFiltersTopRated()
        
        let expectedLanguages = ["en", "es"]
        XCTAssertEqual(viewModel.filterOriginalLanguageTopRated.sorted(), expectedLanguages.sorted(), "Los idiomas originales no coinciden")
        
        let expectedVoteAverages: [Double] = [8.5, 7.5, 9.0]
        XCTAssertEqual(viewModel.filterVoteAverageTopRated.sorted(), expectedVoteAverages.sorted(), "Los promedios de votos no coinciden")
    }
    
    func testFilterMovies() {
        
        let popularMovies = [
            Movie(adult: false, backdropPath: "/path.jpg", genreIds: [12, 28], id: 123, originalLanguage: "en", originalTitle: "Popular Movie", overview: "Overview", popularity: 100.0, posterPath: "/poster.jpg", releaseDate: "2023-01-01", title: "Popular Movie", video: false, voteAverage: 8.5, voteCount: 1000),
            Movie(adult: true, backdropPath: "/path2.jpg", genreIds: [14, 28], id: 124, originalLanguage: "fr", originalTitle: "Adult Movie", overview: "Overview", popularity: 90.0, posterPath: "/poster2.jpg", releaseDate: "2023-01-01", title: "Adult Movie", video: false, voteAverage: 7.0, voteCount: 800)
        ]
        viewModel.popularMovies = popularMovies
        viewModel.exposedPopularResponseMovies(MovieResponse(page: 1, results: popularMovies, totalPages: 1, totalResults: 2))
        
        
        viewModel.filterAdultPopular = false
        viewModel.selectOriginalLanguagePopular = "en"
        viewModel.selectVoteAveragePopular = 90.0
        
        viewModel.filterMovies()
        
        XCTAssertEqual(viewModel.popularMovies.count, 1)
        XCTAssertEqual(viewModel.popularMovies.first?.title, "Popular Movie")
    }
    
    func testGetImageUrl() {
        
        let urlString = "/path.jpg"
        let url = viewModel.getImageUrl(urlString)
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, "\(Constants.showImage)\(urlString)")
        
        let nilUrl = viewModel.getImageUrl(nil)
        XCTAssertNil(nilUrl)
    }
    
    func testChangeToPopular() {
        viewModel.changeToPopular()
        XCTAssertEqual(viewModel.typeSelect, .popular)
    }
    
    func testChangeToTopRated() {
        viewModel.changeToTopRated()
        XCTAssertEqual(viewModel.typeSelect, .topRated)
    }
    
    func testChangeShowFilters() {
        let initialShowFilters = viewModel.showFilters
        viewModel.changeShowFilters()
        XCTAssertEqual(viewModel.showFilters, !initialShowFilters)
    }
    
    func testGetVoteAverage() {
        let voteAverage: Double = 8.0
        let result = viewModel.getVoteAverage(voteAverage)
        XCTAssertEqual(result, 0.8)
    }
}
