//
//  UseCases.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import Foundation
import Alamofire

class UseCases {
    
    //MARK: Get popular movies
    func getPopularMovies(successCallback: @escaping () -> Void, errorCallback: @escaping (NSDictionary) -> Void, networkErrorCallback: @escaping (AFError) -> Void) {
        
        RemoteGateway.basicRequest(url: Constants.popular, body: nil, headers: RemoteGateway.headers, method: .get, successCallback: { data in
            
        }, errorCallback: { error in }, networkErrorCallback: { error in })
    }
    
    //MARK: Get top rated movies
    func getTopRatedMovies(successCallback: @escaping () -> Void, errorCallback: @escaping (NSDictionary) -> Void, networkErrorCallback: @escaping (AFError) -> Void) {
        
        RemoteGateway.basicRequest(url: Constants.topRated, body: nil, headers: RemoteGateway.headers, method: .get, successCallback: { data in
            
        }, errorCallback: { error in }, networkErrorCallback: { error in })
    }
}
