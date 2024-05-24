//
//  MovieViewModel.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import Foundation

class MovieViewModel: ObservableObject {
    
    @Published var popularMovies: MovieResponse? = nil
    @Published var topRatedMovies: MovieResponse? = nil
    @Published var typeSelect: MovieType = .popular
    
    func getPopularMovies() {
        
        UseCases().getPopularMovies(successCallback: { data in
            self.popularMovies = data
        }, errorCallback: { error in }, networkErrorCallback: { error in })
    }
    
    func getTopRatedMovies() {
        
        UseCases().getTopRatedMovies(successCallback: { data in
            self.topRatedMovies = data
        }, errorCallback: { error in }, networkErrorCallback: { error in })
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
}

enum MovieType {
    case popular
    case topRated
}
