//
//  HomeRouter.swift
//  MyMovieDB
//
//  Created by Roni Doang on 13/06/23.
//

import UIKit

final class HomeRouter: HomeRouterDelegate {
    weak var source: UIViewController?
    
    init(view: HomeViewControllerDelegate?) {
        source = view as? UIViewController
    }
    
    func pushToMovieDetail(_ movieId: Int) {
        let vc = DetailMovieViewController()
        vc.movieId = movieId
        source?.navigationController?.pushViewController(vc, animated: true)
    }
}
