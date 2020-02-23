//
//  NetworkManager.swift
//  Novibet
//
//  Created by George Termentzoglou on 22/2/20.
//  Copyright © 2020 George Termentzoglou. All rights reserved.
//

import UIKit

enum ErrorType {
    case badEndPoint
    case badPostValues
    case responseError(String)
    case responseFormat
    case statusCode(Int)
    case jsonParsing(String)
}

typealias Completion = (Bool, ErrorType?)->Void
typealias Result = (Any?, ErrorType?)->Void

class NetworkManager: NSObject {

    enum GamesEndPoint{
        case games
        case updateGames
    }
    
    enum HeadlinesEndPoint{
        case headlines
        case updateHeadlines
    }
    
    fileprivate struct EndPointURLs {
        let login = "http://www.mocky.io/v2/5d8e4bd9310000a2612b5448"
        let games = "http://www.mocky.io/v2/5d7113513300000b2177973a"
        let headlines = "http://www.mocky.io/v2/5d7113ef3300000e00779746"
        let updatedGames = "http://www.mocky.io/v2/5d7114b2330000112177974d"
        let updatedHeadlines = "http://www.mocky.io/v2/5d711461330000d135779748"
    }
    
    static let shared = NetworkManager()
    fileprivate var authorization_header:String?
    fileprivate let endPointURLs = EndPointURLs()
    
    lazy var Auth:Authentication = Authentication()
    lazy var Games:GamesManager = GamesManager()
    lazy var Headlines:HeadlinesManager = HeadlinesManager()
    
    class Authentication {
        
        var dataTask: URLSessionDataTask?
        
        func signIn(username:String,password:String,completion:@escaping Completion) {
            let defaultSession = URLSession(configuration: .default)
            let url = URL(string:NetworkManager.shared.endPointURLs.login)!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let json = [
                "userName": username,
                "password": password
            ]
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) else{
                completion(false,.badPostValues)
                return
            }
            
            dataTask = defaultSession.uploadTask(with: request, from: jsonData) { [weak self] data, response, error in
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
                         NetworkManager.shared.authorization_header = "\(token_type) \(access_token)"
                         DispatchQueue.main.async {
                           completion(true,nil)
                         }
                        return
                     }
                 }
                 DispatchQueue.main.async {
                    completion(false,.jsonParsing("JSONSerialization failed"))
                 }
             }
            catch{
                DispatchQueue.main.async {
                    completion(false,.jsonParsing(error.localizedDescription))
                }
             }
        }
    }
    
    class GamesManager:ModelsManager {
        var defaultSession: URLSession! = URLSession(configuration: .default)
        var operationsQueue:Operations?
        var dataTask: URLSessionDataTask?
        let updateInterval = 2.0
        
        func getGames(endPoint:GamesEndPoint,completion:@escaping Result) {
            var urlString:String?
            
            switch endPoint {
            case .updateGames:
                urlString = NetworkManager.shared.endPointURLs.updatedGames
                
            case .games:
                urlString = NetworkManager.shared.endPointURLs.games
            }
            
            if operationsQueue == nil{
                operationsQueue = Operations(session: defaultSession)
            }
           let dataTask = prepareDownloadTask(urlString: urlString!,completion)
           operationsQueue?.addOperation(dataTask: dataTask)
        }
        
        func getGamesEvents(for element:[GamesJSONElement])->[Event]{
            let events:[Event]? = element.first?.betViews?.first?.competitions?.flatMap { (comp) -> [Event] in
                return (comp.events ?? [])
            }
            return events ?? []
        }
        
        func parseResponseData(data:Data,completion:@escaping Result){
            do {
                let gamesJSON = try JSONDecoder().decode(GamesJSON.self, from: data)
                 DispatchQueue.main.async {
                    completion(gamesJSON,nil)
                 }
             }
            catch{
                print(error)
                DispatchQueue.main.async {
                    completion(nil,.jsonParsing(error.localizedDescription))
                }
             }
        }
    }
   
    class HeadlinesManager:ModelsManager {
           var defaultSession: URLSession! = URLSession(configuration: .default)
           var operationsQueue:Operations?
           var dataTask: URLSessionDataTask?
           let updateInterval = 2.0
        
           func getHeadlines(endPoint:HeadlinesEndPoint,completion:@escaping Result) {
               var urlString:String?
               
               switch endPoint {
               case .updateHeadlines:
                   urlString = NetworkManager.shared.endPointURLs.updatedHeadlines
                   
               case .headlines:
                   urlString = NetworkManager.shared.endPointURLs.headlines
               }
               
               if operationsQueue == nil{
                   operationsQueue = Operations(session: defaultSession)
               }
              let dataTask = prepareDownloadTask(urlString: urlString!,completion)
              operationsQueue?.addOperation(dataTask: dataTask)
           }
           
           func getHeadlinesEvents(for element:[HeadlinesJSONElement])->[Headline]{
//                let headlines:[Headline]? = element.first?.HBetViews
//                return headlines ?? []
            // FIXME: returns only one result so for testing purposes
            let headlines:[Headline] = element.first!.HBetViews!
            return [headlines.first!,headlines.first!,headlines.first!]
           }
           
           func parseResponseData(data:Data,completion:@escaping Result){
               do {
                   let gamesJSON = try JSONDecoder().decode(HeadlinesJSON.self, from: data)
                    DispatchQueue.main.async {
                       completion(gamesJSON,nil)
                    }
                }
               catch{
                   print(error)
                   DispatchQueue.main.async {
                       completion(nil,.jsonParsing(error.localizedDescription))
                   }
                }
           }
       }
    
    class Operations{
        let queue = OperationQueue()
        let session:URLSession
        init(session:URLSession) {
            self.session = session
        }
        
        func addOperation(dataTask:URLSessionDataTask){
            //if queue.operationCount > 1{return}
            let operation = BlockOperation(block: {
              //print("start fetching \(url.absoluteString)")
                dataTask.resume()
            })

            queue.addOperation(operation)
        }
    }
}

protocol ModelsManager: AnyObject {
    
    var defaultSession:URLSession! { get set }
    var dataTask: URLSessionDataTask? { get set }
    
    func prepareDownloadTask(urlString:String,_ completion:@escaping Result)->URLSessionDataTask
    func parseResponseData(data:Data,completion:@escaping Result)
}

extension ModelsManager{
    func prepareDownloadTask(urlString:String,_ completion:@escaping Result)->URLSessionDataTask{
             
             let url = URL(string:urlString)!
                        
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            request.setValue(NetworkManager.shared.authorization_header, forHTTPHeaderField: "Authorization")
            
             let dataTask:URLSessionDataTask = defaultSession.dataTask(with: request) { [weak self] data, response, error in
                 //print("finished fetching \(url.absoluteString)")
              defer {
                self?.dataTask = nil
              }
    
              if let error = error {
                DispatchQueue.main.async {
                    completion(nil,.responseError(error.localizedDescription))
                }
              }
              else if let data = data{
                guard let response = response as? HTTPURLResponse else{
                    DispatchQueue.main.async {
                        completion(nil,.responseFormat)
                    }
                    return
                }
                if response.statusCode != 200{
                    DispatchQueue.main.async {
                        completion(nil,.statusCode(response.statusCode))
                    }
                }
                
                self?.parseResponseData(data: data, completion: completion)
                
              }
            }
             
             return dataTask
         }
}

