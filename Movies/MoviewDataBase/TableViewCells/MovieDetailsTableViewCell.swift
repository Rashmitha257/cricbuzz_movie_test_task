//
//  MovieDetailsTableViewCell.swift
//  Movies
//
//  Created by Softsuave on 16/09/2023.
//

import UIKit

class MovieDetailsTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var moviewImageView: UIImageView!
    @IBOutlet weak var moviewNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    //MARK: - Variables
    var viewModel = MoviewDetailsCellViewModel()
   
    //MARK: - Other functions
    
    /// Updating cell with value provided view view controllers
    /// - Parameter movieData: Movie deatils which need to display
    func updateCellData(movieData: MovieDetails) {
        setupBinder()
        self.moviewNameLabel.text =  movieData.Title
        self.languageLabel.text = "Language: " + (movieData.Language ?? "")
        let year = (movieData.Year.components(separatedBy:  "–").count > 1) ? movieData.Year : movieData.Year.replacingOccurrences(of: "–", with: "")
        self.yearLabel.text = "Year: " + year
        DispatchQueue.global(qos: .background).async {
            if let poster = movieData.Poster, poster.isNotEmpty() {
                self.viewModel.getImageData(url:poster)
            }
        }
    }
    
    /// Setting the binder to receive and do function by observer
    func setupBinder() {
        viewModel.imageData.bind { [weak self] imageData in
            if let imageData = imageData {
                DispatchQueue.main.async {
                    self?.moviewImageView.image = UIImage(data: imageData )
                }
            }
        }
    }
}
