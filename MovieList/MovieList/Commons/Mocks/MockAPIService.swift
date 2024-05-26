//
//  MockAPIService.swift
//  MovieList
//
//  Created by JASS on 26/05/24.
//

import Foundation
import Alamofire

class MockAPIService: APIService {
    
    var popularMoviesResponse: MovieResponse?
    var topRatedMoviesResponse: MovieResponse?
    
    override func getPopularMovies(successCallback: @escaping (MovieResponse) -> Void, errorCallback: @escaping (NSDictionary) -> Void, networkErrorCallback: @escaping (AFError) -> Void) {
        if let response = popularMoviesResponse {
            successCallback(response)
        } else {
            let errorDict: NSDictionary = ["error": "Error"]
            errorCallback(errorDict)
        }
    }
    
    override func getTopRatedMovies(successCallback: @escaping (MovieResponse) -> Void, errorCallback: @escaping (NSDictionary) -> Void, networkErrorCallback: @escaping (AFError) -> Void) {
        if let response = topRatedMoviesResponse {
            successCallback(response)
        } else {
            let errorDict: NSDictionary = ["error": "Error"]
            errorCallback(errorDict)
        }
    }
}
