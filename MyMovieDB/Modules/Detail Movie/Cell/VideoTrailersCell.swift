//
//  VideoTrailersCell.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import UIKit

class VideoTrailersCell: UICollectionViewCell {

    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var playImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        videoView.layer.cornerRadius = 6
        videoView.layer.masksToBounds = false
        videoView.layer.shadowColor = UIColor.black.cgColor
        videoView.layer.shadowOpacity = 0.8
        videoView.layer.shadowOffset = CGSize(width: 2, height: 2)
        videoView.layer.shadowRadius = 4
        
        playImg.layer.cornerRadius = 6
        playImg.layer.masksToBounds = false
        playImg.layer.shadowColor = UIColor.black.cgColor
        playImg.layer.shadowOpacity = 0.8
        playImg.layer.shadowOffset = CGSize(width: 2, height: 2)
        playImg.layer.shadowRadius = 4
    }
    
    func configureCell(with videoKey: String) {
        if let bgImageUrl = URL(
            string: "https://img.youtube.com/vi/\(videoKey)/mqdefault.jpg") {
            videoImg.kf.setImage(with: bgImageUrl, placeholder: UIImage(named: "icDownloadImg"))
        } else {
            videoImg.image = UIImage(named: "icEmptyImg")
        } 
        videoImg.kf.indicatorType = .activity
    }

}
