//
//  APIService.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import Foundation
import Alamofire

class APIService {
    
    private let decoder = JSONDecoder()
    private let session: Session
    
    init(session: Session = AF) {
        self.session = session
    }
    
    //MARK: Get popular movies
    func getPopularMovies(successCallback: @escaping (MovieResponse) -> Void, errorCallback: @escaping (NSDictionary) -> Void, networkErrorCallback: @escaping (AFError) -> Void) {
        
        NetworkManager.basicRequest(url: Constants.popular, method: .get, session: session, successCallback: { data in
            do {
                let decodedElement = try self.decoder.decode(MovieResponse.self, from: data)
                successCallback(decodedElement)
            } catch {
                print("error getPopularMovies catch: ", error)
            }
        }, errorCallback: { error in
            errorCallback(["error": error])
        }, networkErrorCallback: { error in
            networkErrorCallback(error)
        })
    }
    
    //MARK: Get top rated movies
    func getTopRatedMovies(successCallback: @escaping (MovieResponse) -> Void, errorCallback: @escaping (NSDictionary) -> Void, networkErrorCallback: @escaping (AFError) -> Void) {
        
        NetworkManager.basicRequest(url: Constants.topRated, method: .get, session: session, successCallback: { data in
            
            do {
                let decodedElement = try self.decoder.decode(MovieResponse.self, from: data)
                successCallback(decodedElement)

            } catch {
                print("error getTopRatedMovies catch: ", error)
            }
            
        }, errorCallback: { error in
            errorCallback(["error": error])
        }, networkErrorCallback: { error in
            networkErrorCallback(error)
        })
    }
}
