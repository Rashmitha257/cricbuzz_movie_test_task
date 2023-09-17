//
//  RatingCollectionViewCell.swift
//  Movies
//
//  Created by Softsuave on 16/09/2023.
//

import UIKit

class RatingCollectionViewCell: UICollectionViewCell {
  //MARK: - IBOutlets
    @IBOutlet weak var starImage: UIImageView!
    
    //MARK: - Variables
    var ratingPercentage: Float = 0.0
    var cellCount: Int = 0
    
    //MARK: - Other menthods
    
    /// Setting initial cell UI
    func setUpImageView(ratingValue: String) {
        ratingPercentage = getPercentage(from: ratingValue)
        print(ratingPercentage, "Rating percentage value", ratingPercentage.truncatingRemainder(dividingBy: 1) != 0)
        if ratingPercentage >= Float(cellCount) {
            starImage.image = UIImage(systemName: "star.fill")
        } else if round(ratingPercentage) == Float(cellCount - 1), ratingPercentage.remainder(dividingBy: 1) > 0  {
            starImage.image = UIImage(systemName: "star.fill.left")
        } else {
            starImage.image = UIImage(systemName: "star")
        }
    }
    
    /// Rating is in not in unuform formate so getting rating in one formate(Percentage)
    /// - Parameter rating: Rating value
    /// - Returns: Percentage converted rating value
    func getPercentage(from rating: String) -> Float {
        var percentage = rating
        if rating.contains("/100") || rating.contains("%") {
            percentage = percentage.replacingOccurrences(of: "%", with: "")
            percentage = percentage.replacingOccurrences(of: "/100", with: "")
            return (Float(percentage) ?? 0)/10
        } else  {
            percentage = percentage.replacingOccurrences(of: "/10", with: "")
            return Float(percentage) ?? 0
        }
    }
    
    
}
