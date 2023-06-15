//
//  DetailMovieRouter.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import UIKit

final class DetailMovieRouter: DetailMovieRouterDelegate {
    weak var source: UIViewController?
    
    init(view: DetailMovieViewControllerDelegate?) {
        source = view as? UIViewController
    }
    
    func backToDiscover() {
        source?.navigationController?.popViewController(animated: true)
    }
    
    func pushToReview(_ movieId: Int) {
        let vc = ReviewListViewController()
        vc.movieId = movieId
        source?.navigationController?.pushViewController(vc, animated: true)
    }
}
