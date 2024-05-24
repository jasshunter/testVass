//
//  RemoteGateway.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import Foundation
import Alamofire

struct RemoteGateway {
    
    static var headers: HTTPHeaders = [.authorization(bearerToken: Constants.bearerToken)]
    
    static func basicRequest (url: String, body: [String: Any]?, headers: HTTPHeaders, method: HTTPMethod, successCallback: @escaping (NSDictionary) -> Void, errorCallback: @escaping (NSDictionary) -> Void, networkErrorCallback: @escaping (AFError) -> Void) {
        
        AF.request("\(Constants.api)\(url)", method: method, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseData { response in
#if DEBUG
                print("\(method.rawValue) - \(url): ----------------------START----------------------")
                if !headers.isEmpty {
                    if let jsonHeaders = try? JSONSerialization.data(withJSONObject: headers.map { $0.description }, options: .prettyPrinted),
                       let prettyPrintedString = String(data: jsonHeaders, encoding: .utf8) {
                        print("HEADER REQUEST ->\n\(prettyPrintedString)")
                    }
                }
                if let bodyJson = body, let jsonData = try? JSONSerialization.data(withJSONObject: bodyJson, options: .prettyPrinted),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("REQUEST ->\n\(jsonString)")
                }
#endif
                switch response.result {
                case .success(let data):
                    do {
                        let asJSON = try JSONSerialization.jsonObject(with: data)
#if DEBUG
                        if let jsonData = try? JSONSerialization.data(withJSONObject: asJSON, options: .prettyPrinted),
                           let jsonString = String(data: jsonData, encoding: .utf8) {
                            print("RESPONSE ->\n\(jsonString)")
                        }
                        print("----------------------END----------------------")
#endif
                        guard let data2 = asJSON as? NSDictionary else {return}
                        let statusCode = response.response?.statusCode
                        
                        if (200 ... 300).contains(statusCode ?? 0) {
                            
                            successCallback(data2)
                        } else {
                            
                            errorCallback(data2)
                        }
                    } catch {
                        
                        print("Error while decoding response: \(error) from: \(String(data: data, encoding: .utf8) ?? "")")
                    }
                case .failure(let error):
                    networkErrorCallback(error)
                }
            }
    }
}
