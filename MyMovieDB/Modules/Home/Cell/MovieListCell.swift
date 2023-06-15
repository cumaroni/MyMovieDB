//
//  MovieListCell.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import UIKit
import Kingfisher

class MovieListCell: UITableViewCell {

    @IBOutlet weak var movieBackgroundImg: UIImageView!
    @IBOutlet weak var movieBackgroundView: UIView!
    @IBOutlet weak var moviePosterImg: UIImageView!
    @IBOutlet weak var moviePosterView: UIView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieDescLbl: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        moviePosterView.layer.cornerRadius = 6
        moviePosterView.layer.masksToBounds = false
        moviePosterView.layer.shadowColor = UIColor.black.cgColor
        moviePosterView.layer.shadowOpacity = 0.8
        moviePosterView.layer.shadowOffset = CGSize(width: 2, height: 2)
        moviePosterView.layer.shadowRadius = 2
        
        lineView.alpha = 0.2
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with data: MoviesListModel) {
        if let bgImageUrl = URL(
            string: "https://image.tmdb.org/t/p/w500\(data.backgroundPath)") {
            movieBackgroundImg.kf.setImage(with: bgImageUrl, placeholder: UIImage(named: "icDownloadImg"))
        } else {
            movieBackgroundImg.image = UIImage(named: "icEmptyImg")
        }
        
        if let posterImgUrl = URL(
            string: "https://image.tmdb.org/t/p/w500\(data.posterPath)") {
            moviePosterImg.kf.setImage(with: posterImgUrl)
        } else {
            moviePosterImg.image = UIImage(named: "icEmptyImg")
        }
        
        movieBackgroundImg.kf.indicatorType = .activity
        moviePosterImg.kf.indicatorType = .activity
        movieTitleLbl.text = data.title
        movieDescLbl.text = data.overview 
    }
    
}
