//
//  NetworkManager.swift
//  Novibet
//
//  Created by George Termentzoglou on 22/2/20.
//  Copyright © 2020 George Termentzoglou. All rights reserved.
//

import UIKit

enum ErrorType {
    case responseError(String)
    case responseFormat
    case statusCode(Int)
    case jsonParsing
}

typealias Completion = (Bool, ErrorType?)->Void
class NetworkManager: NSObject {

    struct EndPoints {
        let login = "http://www.mocky.io/v2/5d8e4bd9310000a2612b5448"
        let games = "http://www.mocky.io/v2/5d7113513300000b2177973a"
        let headlines = "http://www.mocky.io/v2/5d7113ef3300000e00779746"
        let updatedGames = "http://www.mocky.io/v2/5d7114b2330000112177974d"
        let updatedHeadlines = "http://www.mocky.io/v2/5d711461330000d135779748"
    }
    
    static let shared = NetworkManager()
    private var authentication_header:String?
    let endPoints = EndPoints()
    let Auth:Authentication = Authentication()
    
    class Authentication {
        
        var dataTask: URLSessionDataTask?
        
        func signIn(username:String,password:String,completion:@escaping Completion) {
            let defaultSession = URLSession(configuration: .default)
            let url = URL(string:NetworkManager.shared.endPoints.login)!
            
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
              defer {
                self?.dataTask = nil
              }
    
              if let error = error {
                DispatchQueue.main.async {
                    completion(false,.responseError(error.localizedDescription))
                }
              }
              else if let data = data{
                guard let response = response as? HTTPURLResponse else{
                    DispatchQueue.main.async {
                        completion(false,.responseFormat)
                    }
                    return
                }
                if response.statusCode != 200{
                    DispatchQueue.main.async {
                        completion(false,.statusCode(response.statusCode))
                    }
                }
                
                self?.parseResponseData(data: data, completion: completion)
                
              }
            }
            dataTask?.resume()
        }
        
        func parseResponseData(data:Data,completion:@escaping Completion){
            do {
                 if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                     if let token_type = json["token_type"] as? String, let access_token = json["access_token"] as? String {
                         NetworkManager.shared.authentication_header = "\(token_type) \(access_token)"
                         DispatchQueue.main.async {
                           completion(true,nil)
                         }
                        return
                     }
                 }
                 DispatchQueue.main.async {
                    completion(false,.jsonParsing)
                 }
             }
            catch _{
                DispatchQueue.main.async {
                 completion(false,.jsonParsing)
                }
             }
        }
    }
}

