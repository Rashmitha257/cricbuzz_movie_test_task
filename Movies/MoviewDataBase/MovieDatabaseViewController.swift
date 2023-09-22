//
//  ViewController.swift
//  Movies
//
//  Created by Softsuave on 16/09/2023.
//

import UIKit

class MovieDatabaseViewController: UIViewController {
   //MARK: - IBoutlets
    @IBOutlet weak var movieDatabaseTableView: UITableView!
    
    //MARK: - Variables
    private let viewModel = MovieDatabaseViewModel()
    var movieDatabaseList = [Section<Any>]()
    var allMovies = [MovieDetails]()
    var isSearchEnable = false

    //MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinder()
        viewModel.getMovieList()
    }

    //MARK: - Other functions
    
    /// Setting the binder to do functions after listen from observers
    func setupBinder() {
        viewModel.movieDetails.bind { [weak self] movieDatabase in
            if let movieData = movieDatabase {
                self?.allMovies = movieData
            }
        }
        
        viewModel.listWithSection.bind { [weak self]  movieDatabase in
            if let listOfMoviewWithSection = movieDatabase {
                self?.movieDatabaseTableView.isHidden = false
                self?.movieDatabaseList = listOfMoviewWithSection
                self?.movieDatabaseTableView.reloadData()
            } else {
                self?.movieDatabaseTableView.isHidden = true
            }
        }
        
        viewModel.filterdMovieList.bind { [weak self] movieDatabase in
            if let movieData = movieDatabase {
                self?.movieDatabaseList = [Section<Any>]()
                self?.movieDatabaseList.append(Section(title: "All Movies", expanded: true, listData: movieData))
                self?.movieDatabaseTableView.reloadData()
            }
        }
    }
    
}
//MARK: - Table view Delegate and data source
extension MovieDatabaseViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
    movieDatabaseList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieDatabaseList[section].listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        isSearchEnable ? 0 : 44
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  movieDatabaseList[indexPath.section].expanded ? UITableView.automaticDimension : 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        header.customIniit(title: movieDatabaseList[section].title, section: section, delegate: self, isFromAllMoview: section == 4 ? true : false)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = getCellIdentifier(section: indexPath.section)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let configurableCell = cell as? TableViewCellProtocol {
            let data = movieDatabaseList[indexPath.section].listData[indexPath.row]
            configurableCell.configure(with: data)
        }
        return cell
    }
    
    /// Get cell identifire by using section
    /// - Parameter section: section to get identifier
    /// - Returns: cell identifier name
    func getCellIdentifier(section: Int) -> String {
        switch section {
        case 4:
            return moviewDetailsCellIdentifier
        default:
            return lableCellIdentifier
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 4 {
            navigationToMoviewDetailsScreen(moviewData: movieDatabaseList[indexPath.section].listData[indexPath.row] as! MovieDetails)
        } else if let filteredMovie = getFilteredList(section: indexPath.section, comparableValue: movieDatabaseList[indexPath.section].listData[indexPath.row] as! String  ) {
            navigateToMoviewListScreen(list: filteredMovie)
        }
    }
    
    
    /// get filter value of moview list depending on requirment by using section value
    /// - Parameters:
    ///   - section: section value
    ///   - comparableValue: string need to compare to get required data vby filtering
    /// - Returns: Filtered movie list
    func getFilteredList(section: Int, comparableValue: String ) -> [MovieDetails]? {
        switch section {
        case 0:
            return allMovies.filter({$0.Year.components(separatedBy: "-").contains(comparableValue)})
        case 1:
            return allMovies.filter({$0.Genre.components(separatedBy: ",").contains(comparableValue)})
        case 2:
            return allMovies.filter({$0.Director.components(separatedBy: ",").contains(comparableValue)}).sorted()
        case 3:
            return allMovies.filter({$0.Actors.components(separatedBy: ",").contains(comparableValue)})
        default:
            return nil
        }
    }
   
}

//MARK: - Navigation functions
extension MovieDatabaseViewController {
    
    /// Navigating to moview details screen
    /// - Parameter moviewData: Displayable movie data
    func navigationToMoviewDetailsScreen(moviewData: MovieDetails) {
        let movieDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviewDetailsViewController") as! MoviewDetailsViewController
        movieDetailsVC.moviewDetails = moviewData
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
    
    /// Navigating to moview list screen
    /// - Parameter moviewData: Displayable movie list
    func navigateToMoviewListScreen(list: [MovieDetails]) {
        let movieDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        movieDetailsVC.movieList = list
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}

//MARK: - Search delegate implementation
extension MovieDatabaseViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if  searchText.trim() != "" {
            isSearchEnable = true
            viewModel.getFilteredMoview(searchText: searchText.trim().lowercased())
        } else {
            isSearchEnable = false
            viewModel.getAllList()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//MARK: - ExapandableHeaderViewdelegate implementation
extension MovieDatabaseViewController: ExapandableHeaderViewdelegate {
    func toggeleSection(header: HeaderView, section: Int) {
        movieDatabaseList[section].expanded = !movieDatabaseList[section].expanded
        movieDatabaseTableView.beginUpdates()
        for i in 0 ..< movieDatabaseList[section].listData.count {
            movieDatabaseTableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        movieDatabaseTableView.endUpdates()
    }
    
    /// implented to show movie list screen for all movies
    func navigateToMoveListScreen() {
        self.navigateToMoviewListScreen(list: allMovies)
    }
    
}
