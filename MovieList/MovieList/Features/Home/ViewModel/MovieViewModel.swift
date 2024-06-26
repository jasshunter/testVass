//
//  MovieViewModel.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import Foundation

#if DEBUG
extension MovieViewModel {
    func exposedPopularResponseMovies(_ data: MovieResponse? = nil) {
        self.popularResponseMovies = data
    }
    func exposedTopRatedResponseMovies(_ data: MovieResponse? = nil) {
        self.topRatedResponseMovies = data
    }
    func exposedGetFiltersPopular() {
        self.getFiltersPopular()
    }
    func exposedGetFiltersTopRated() {
        self.getFiltersTopRated()
    }
}
#endif

class MovieViewModel: ObservableObject {
    
    private var apiService: APIService
    private var popularResponseMovies: MovieResponse? = nil
    private var topRatedResponseMovies: MovieResponse? = nil
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var typeSelect: MovieType = .popular
    @Published var searchPopular: String = ""
    @Published var searchTopRated: String = ""
    @Published var showFilters: Bool = false
    @Published var filterAdultPopular: Bool = false
    @Published var filterOriginalLanguagePopular: [String] = []
    @Published var selectOriginalLanguagePopular: String? = nil
    @Published var filterVoteAveragePopular: [Double] = []
    @Published var selectVoteAveragePopular: Double = 100
    @Published var filterAdultTopRated: Bool = false
    @Published var filterOriginalLanguageTopRated: [String] = []
    @Published var selectOriginalLanguageTopRated: String? = nil
    @Published var filterVoteAverageTopRated: [Double] = []
    @Published var selectVoteAverageTopRated: Double = 100
    
    init(apiService: APIService = APIService()) {
        
        self.apiService = apiService
        getPopularMovies()
        getTopRatedMovies()
    }
    
    func getPopularMovies() {
        
        apiService.getPopularMovies(successCallback: { data in
            self.popularResponseMovies = data
            self.popularMovies = data.results ?? []
            self.getFiltersPopular()
        }, errorCallback: { error in }, networkErrorCallback: { error in })
    }
    
    func getTopRatedMovies() {
        
        apiService.getTopRatedMovies(successCallback: { data in
            self.topRatedResponseMovies = data
            self.topRatedMovies = data.results ?? []
            self.getFiltersTopRated()
        }, errorCallback: { error in }, networkErrorCallback: { error in })
    }
    
    func searchMovies(search: String) {
        
        switch (typeSelect) {
        case .popular:
            guard let movies = popularResponseMovies?.results else {
                popularMovies = []
                return
            }
            if searchPopular.isEmpty {
                popularMovies = movies
            } else {
                popularMovies = movies.filter { $0.originalTitle?.lowercased().contains(searchPopular.lowercased()) ?? false }
            }
        case .topRated:
            guard let movies = topRatedResponseMovies?.results else {
                topRatedMovies = []
                return
            }
            if searchTopRated.isEmpty {
                topRatedMovies = movies
            } else {
                topRatedMovies = movies.filter { $0.originalTitle?.lowercased().contains(searchTopRated.lowercased()) ?? false }
            }
        }
    }
    
    private func getFiltersPopular() {
        
        guard let movies = popularResponseMovies?.results else { return }
        filterOriginalLanguagePopular = Array(Set(movies.compactMap { $0.originalLanguage }))
        filterVoteAveragePopular = Array(Set(movies.compactMap { $0.voteAverage }))
    }
    
    private func getFiltersTopRated() {
        
        guard let movies = topRatedResponseMovies?.results else { return }
        filterOriginalLanguageTopRated = Array(Set(movies.compactMap { $0.originalLanguage }))
        filterVoteAverageTopRated = Array(Set(movies.compactMap { $0.voteAverage }))
    }
    
    func filterMovies() {
        
        switch (typeSelect) {
        case .popular:
            popularMovies = (popularResponseMovies?.results ?? []).filter { $0.adult == filterAdultPopular }
            if let languagePopular = selectOriginalLanguagePopular {
                popularMovies = popularMovies.filter { $0.originalLanguage == languagePopular }
            }
            popularMovies = popularMovies.filter { (0...(selectVoteAveragePopular/10)).contains($0.voteAverage ?? 0) }
        case .topRated:
            topRatedMovies = (topRatedResponseMovies?.results ?? []).filter { $0.adult == filterAdultTopRated }
            if let languagePopular = selectOriginalLanguageTopRated {
                topRatedMovies = topRatedMovies.filter { $0.originalLanguage == languagePopular }
            }
            topRatedMovies = topRatedMovies.filter { (0...(selectVoteAverageTopRated/10)).contains($0.voteAverage ?? 0) }
        }
        
        showFilters.toggle()
    }
 
    func getImageUrl(_ patch: String?) -> URL? {
        
        guard let imagePatch = patch else { return nil }
        guard let imageUrl = URL(string: "\(Constants.showImage)\(imagePatch)") else { return nil }
        return imageUrl
    }
    
    func changeToPopular() {
        typeSelect = .popular
    }
    
    func changeToTopRated() {
        typeSelect = .topRated
    }
    
    func changeShowFilters() {
        showFilters.toggle()
    }
    
    func getVoteAverage(_ voteAverage: Double?) -> Double {
        
        guard let average = voteAverage else { return 0 }
        return average/10
    }
}

enum MovieType {
    case popular
    case topRated
}
