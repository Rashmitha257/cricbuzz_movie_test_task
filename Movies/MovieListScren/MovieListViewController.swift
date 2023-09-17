//
//  MovieListViewController.swift
//  Movies
//
//  Created by Softsuave on 17/09/2023.
//

import UIKit

class MovieListViewController: UIViewController {
    
    //MARK: - Variables
    var movieList = [MovieDetails]()

    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
}

//MARK: - Navigation functions
extension MovieListViewController {
    //MARK: - Other functions
    
    /// Navigate to details screen once click on list
    /// - Parameter moviewData: Moview detals need to show in moview details screen
    func navigationToMoviewDetailsScreen(moviewData: MovieDetails) {
        let movieDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviewDetailsViewController") as! MoviewDetailsViewController
        movieDetailsVC.moviewDetails = moviewData
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
}

//MARK: - Table view delegate and data source functions
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell", for: indexPath) as! MovieDetailsTableViewCell
        cell.updateCellData(movieData: movieList[indexPath.row] )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationToMoviewDetailsScreen(moviewData: movieList[indexPath.row])
    }
    
}
