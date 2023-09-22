//
//  MovieListViewController.swift
//  Movies
//
//  Created by Softsuave on 17/09/2023.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var movieListTableView: UITableView!
    //MARK: - Variables
    var movieList = [MovieDetails]()
    var filteredMoview = [MovieDetails]()

    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredMoview = movieList
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    
    /// Addeded sorting for struct depending on requirments
    /// - Parameter sender: buton action
    @IBAction func actionOnFilter(_ sender: Any) {
        
        let alertView = UIAlertController()
        let actionOnYear = UIAlertAction(title: "Year", style: .default) {_ in
            self.filteredMoview = self.movieList.sorted {$0.Year < $1.Year}
            self.movieListTableView.reloadData()
        }
        alertView.addAction(actionOnYear)
        
        let actionOnAscending = UIAlertAction(title: "Ascending", style: .default) {_ in
            self.filteredMoview = self.movieList.sorted {$0.Title < $1.Title}
            self.movieListTableView.reloadData()
        }
        alertView.addAction(actionOnAscending)
        
        let actionOndescending = UIAlertAction(title: "Descending", style: .default) {_ in
            self.filteredMoview = self.movieList.sorted {$0.Title > $1.Title}
            self.movieListTableView.reloadData()
        }
        alertView.addAction(actionOndescending)
        
        let actionOnAllMovie = UIAlertAction(title: "All Movie's", style: .default) {_ in
            self.filteredMoview = self.movieList
            self.movieListTableView.reloadData()
        }
        alertView.addAction(actionOnAllMovie)
        
        let cancellAction = UIAlertAction(title: "Cancell", style: .default) {_ in
            self.dismiss(animated: true)
            
        }
        alertView.addAction(cancellAction)
        
        navigationController?.present(alertView, animated: true)
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
        filteredMoview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell", for: indexPath) as! MovieDetailsTableViewCell
        cell.updateCellData(movieData: filteredMoview[indexPath.row] )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationToMoviewDetailsScreen(moviewData: filteredMoview[indexPath.row])
    }
    
}
