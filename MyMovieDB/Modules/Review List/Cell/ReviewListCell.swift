//
//  ReviewListCell.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import UIKit

class ReviewListCell: UITableViewCell {

    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var reviewLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImg.layer.cornerRadius = avatarImg.frame.width / 2 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data: ReviewListModel) {
        var path = data.authorPhoto
        var avatarPath = String(path.dropFirst())
        
        if let avatarURL = URL(
            string: "\(avatarPath)") {
            if avatarPath.contains("https") {
                avatarImg.kf.setImage(with: avatarURL)
            } else {
                avatarImg.image = UIImage(named: "icProfile")
            }
        } else {
            avatarImg.image = UIImage(named: "icProfile")
        }
        
        avatarImg.kf.indicatorType = .activity
        nameLbl.text = data.authorName
        ratingLbl.text = "\(data.rating)"
        ratingView.isHidden = ratingLbl.text == "0.0"
        if let convertedDate = data.date.convertToFormattedDate(
            fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
            toFormat: "dd MMM yyyy"
        ) {
            dateLbl.text = "Updated at " + convertedDate
        } else {
            dateLbl.isHidden = true
        }
        reviewLbl.text = data.reviews
    }
    
}
