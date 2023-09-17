//
//  NetworkManager.swift
//  Movies
//
//  Created by Softsuave on 16/09/2023.
//

import Foundation
import UIKit

final class NetworkManager {
    static let getNetworkManagerInstance = NetworkManager()
    
    private init() { }
    
    func getJsonFile(filename fileName: String) -> [MovieDetails]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([MovieDetails].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
     func getAllMovieList(completionHandler: (_ result: [MovieDetails]?, _ error: String?) -> (Void)) {
        if let movieList = getJsonFile(filename: "movies") {
            completionHandler( movieList,nil)
        } else {
            completionHandler(nil, "Unable to fetch json file please try again or check")
        }
    }
    
    func downloadImage(_ urlString: String, completion: @escaping (_ image: Data?, _ urlString: String?) -> ()) {
           guard let url = URL(string: urlString) else {
               completion(nil, urlString)
              return
          }
          URLSession.shared.dataTask(with: url) { (data, response,error) in
              if error != nil {
                 completion(nil, urlString)
                return
             }
             guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                 completion(nil, urlString)
                return
             }
             if let data = data {
                 completion(data, urlString)
                return
             }
              completion(nil, urlString)
          }.resume()
       }
   
}
