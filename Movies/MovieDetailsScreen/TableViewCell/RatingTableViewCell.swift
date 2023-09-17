//
//  RatingTableViewCell.swift
//  Movies
//
//  Created by Softsuave on 16/09/2023.
//

import UIKit

class RatingTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingCollectionView: UICollectionView!
    
    //MARK: - Variable
    var ratingdata = Rating()
    
    //MARK: - Other functions
    func updateRatingCell(rating: Rating) {
        self.ratingLabel.text = rating.Source
        ratingdata = rating
        ratingCollectionView.reloadData()
    }
    

}

extension  RatingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RatingCollectionViewCell", for: indexPath as IndexPath) as! RatingCollectionViewCell
        cell.cellCount = indexPath.row + 1
        cell.setUpImageView(ratingValue: ratingdata.Value ?? "")
        return cell
    }
    
}
