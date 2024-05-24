//
//  UseCases.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import Foundation
import Alamofire

class UseCases {
    
    private let decoder = JSONDecoder()
    
    //MARK: Get popular movies
    func getPopularMovies(successCallback: @escaping (MovieResponse) -> Void, errorCallback: @escaping (NSDictionary) -> Void, networkErrorCallback: @escaping (AFError) -> Void) {
        
        RemoteGateway.basicRequest(url: Constants.popular, body: nil, headers: RemoteGateway.headers, method: .get, successCallback: { data in
            
            do {
                let decodedElement = try self.decoder.decode(MovieResponse.self, from: data)
                successCallback(decodedElement)

            } catch {
                print("error getPopularMovies catch: ", error)
            }
            
        }, errorCallback: { error in }, networkErrorCallback: { error in })
    }
    
    //MARK: Get top rated movies
    func getTopRatedMovies(successCallback: @escaping (MovieResponse) -> Void, errorCallback: @escaping (NSDictionary) -> Void, networkErrorCallback: @escaping (AFError) -> Void) {
        
        RemoteGateway.basicRequest(url: Constants.topRated, body: nil, headers: RemoteGateway.headers, method: .get, successCallback: { data in
            
            do {
                let decodedElement = try self.decoder.decode(MovieResponse.self, from: data)
                successCallback(decodedElement)

            } catch {
                print("error getPopularMovies catch: ", error)
            }
            
        }, errorCallback: { error in }, networkErrorCallback: { error in })
    }
}
