//
//  MovieDatabaseViewModel.swift
//  Movies
//
//  Created by Softsuave on 16/09/2023.
//

import Foundation

class MovieDatabaseViewModel {
    //MARK: - Variables
    var movieDetails: ObservableObject<[MovieDetails]?> = ObservableObject(nil)
    var listWithSection: ObservableObject<[Section<Any>]?> = ObservableObject(nil)
    var filterdMovieList: ObservableObject<[MovieDetails]?> = ObservableObject(nil)
    var allMoview = [MovieDetails]()
    
    //MARK: - Other functions
    
    ///  Get moview list from json
    func getMovieList() {
        NetworkManager.getNetworkManagerInstance.getAllMovieList { result, error in
            if let result = result {
                allMoview = result
                movieDetails.value = result
                updateAllSection(moviewDetails: result)
            }
        }
    }
    
    /// Setting movie related data with section value
    /// - Parameter moviewDetails: moview details gor from json
    func updateAllSection(moviewDetails: [MovieDetails]) {
        var yearArray = Set<String>()
        var genreArray = Set<String>()
        var actors = Set<String>()
        var directors = Set<String>()
        let allMovies = moviewDetails
        moviewDetails.forEach({
                for year in $0.Year.components(separatedBy: "–") {
                    if year.isNotEmpty() {
                        yearArray.insert(year)
                    }
                }
            
                for genre in $0.Genre.components(separatedBy: ",") {
                    if genre.isNotEmpty() {
                        genreArray.insert(genre)
                    }
                }
            
         
                for director in $0.Director.components(separatedBy: ",") {
                    if director.isNotEmpty() {
                        directors.insert(director)
                    }
                }
            
            
                for actor in $0.Actors.components(separatedBy: ",") {
                    if actor.isNotEmpty() {
                        actors.insert(actor)
                    }
                }
    
        })
        var movieDatabaseList = [Section<Any>]()
        movieDatabaseList.append(Section(title:  "Year", expanded: false, listData: yearArray.sorted()))
        movieDatabaseList.append(Section(title: "Genre", expanded: false, listData: genreArray.sorted()))
        movieDatabaseList.append(Section(title: "Directors", expanded: false, listData: directors.sorted()))
        movieDatabaseList.append(Section(title: "Actors", expanded: false, listData: actors.sorted()))
        movieDatabaseList.append(Section(title: "All Movies", expanded: false, listData: allMovies))
        listWithSection.value = movieDatabaseList
    }

    
    /// Filtering only searched movie list
    /// - Parameter searchText: Searching string
    func getFilteredMoview(searchText: String) {
        var allFilteredMoview =  [MovieDetails]()
        allMoview.forEach({ movie in
            if movie.Title.lowercased().contains(searchText) ||
                movie.Year.lowercased().contains(searchText) ||
                movie.Actors.lowercased().contains(searchText) ||
                movie.Director.lowercased().contains(searchText)  ||
                movie.Genre.lowercased().contains(searchText)
            {
                allFilteredMoview.append(movie)
            }
            
        })
        filterdMovieList.value = allFilteredMoview
    }
    
    /// To get all list after cancelling searching
    func getAllList() {
        movieDetails.value = allMoview
        updateAllSection(moviewDetails: allMoview)
    }
    
    
}
