//
//  GenreListCell.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import UIKit

class GenreListCell: UICollectionViewCell, GenreCollectionCellProtocol {
     
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(with data: GenreListModel) {
        self.genreLbl.text = data.name
    }
    
    func setSelected(_ selected: Bool) { 
        self.lineView.isHidden = !selected
    }

}
