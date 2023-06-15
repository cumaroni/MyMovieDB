//
//  ReviewListRouter.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//


import UIKit

final class ReviewListRouter: ReviewListRouterDelegate {
    weak var source: UIViewController?
    
    init(view: ReviewListViewControllerDelegate?) {
        source = view as? UIViewController
    }
    
    func backToMovieDetail() {
        source?.navigationController?.popViewController(animated: true)
    } 
}
