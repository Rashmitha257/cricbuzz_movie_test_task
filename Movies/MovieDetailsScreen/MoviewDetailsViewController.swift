//
//  MoviewDetailsViewController.swift
//  Movies
//
//  Created by Softsuave on 16/09/2023.
//

import UIKit

class MoviewDetailsViewController: UIViewController {
   
    //MARK: - IBOutlets
    @IBOutlet weak var moviewPosterImage: UIImageView!
    @IBOutlet weak var lablelForGenreAndDate: UILabel!
    @IBOutlet weak var summuryLabel: UILabel!
    @IBOutlet weak var caseAndCrewLabel: UILabel!
    @IBOutlet weak var ratingTableView: UITableView!
    @IBOutlet weak var moviewName: UILabel!
    
    //MARK: - Variables
    var moviewDetails = MovieDetails()
    var isExapandable: Bool = false
    var viewModel = MoviewDetailsViewModel()
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupBinder()
        updateMoviewDetails()
    }
    
    //MARK: - IBActions
    @IBAction func actionOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Other functions
    
    /// Updating moview details screen
    func updateMoviewDetails() {
        self.lablelForGenreAndDate.text = moviewDetails.Genre + "  -  " + (moviewDetails.Released ?? "")
        self.moviewName.text = moviewDetails.Title
        self.summuryLabel.text = moviewDetails.Plot
        DispatchQueue.global(qos: .background).async {
            if let poster = self.moviewDetails.Poster, poster.isNotEmpty() {
                self.viewModel.getImageData(url:poster)
            }
        }
        self.caseAndCrewLabel.text = moviewDetails.Actors
    }
    
    /// Setting the binder to listen from observer
    func setupBinder() {
        viewModel.imageData.bind { [weak self] imageData in
            if let imageData = imageData {
                DispatchQueue.main.async {
                    self?.moviewPosterImage.image = UIImage(data: imageData )
                }
            }
        }
    }
}

//MARK: - TableView delegate and data source menthods
extension MoviewDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        header.customIniit(title: "Ratings", section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isExapandable {
          return  moviewDetails.Ratings?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell") as! RatingTableViewCell
        cell.updateRatingCell(rating: moviewDetails.Ratings?[indexPath.row] ?? Rating())
        return cell
    }
}

//MARK: - ExapandableHeaderViewdelegate functions
extension MoviewDetailsViewController : ExapandableHeaderViewdelegate{
    
    func toggeleSection(header: HeaderView, section: Int) {
        isExapandable = !isExapandable
        ratingTableView.reloadData()
        
    }
}
