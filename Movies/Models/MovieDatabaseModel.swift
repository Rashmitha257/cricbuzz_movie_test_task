//
//  MovieDatabaseModel.swift
//  Movies
//
//  Created by Softsuave on 16/09/2023.
//

import Foundation


struct MovieList: Codable {
    var list = [MovieDetails]()
}

struct MovieDetails: Codable, Comparable {
    static func == (lhs: MovieDetails, rhs: MovieDetails) -> Bool {
        lhs.Title == rhs.Title
    }

    static func < (lhs: MovieDetails, rhs: MovieDetails) -> Bool {
        lhs.Title > rhs.Title
    }
    
    var Title: String = ""
    var Year: String = ""
    var Rated: String?
    var Released: String?
    var Runtime: String?
    var Genre: String = ""
    var Director: String = ""
    var Writer: String?
    var Actors: String = ""
    var Plot: String?
    var Language: String?
    var Country: String?
    var Awards: String?
    var Poster: String?
    var Ratings: [Rating]?
    var Metascore: String?
    var imdbRating: String?
    var imdbVotes: String?
    var imdbID: String?
    var DVD: String?
    var BoxOffice: String?
    var Production: String?
    var Website: String?
    var Response: String?
    var image: Data?
}

struct Rating: Codable {
    var Source: String?
    var Value: String?
}

struct Section<T> {
    var title: String
    var expanded: Bool
    var listData: [T]
}
