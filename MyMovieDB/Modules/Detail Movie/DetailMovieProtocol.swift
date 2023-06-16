//
//  DetailMovieProtocol.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import UIKit
 
protocol DetailMovieViewControllerDelegate: AnyObject {
    var movieId: Int { get }
    func setDetailMovieData(_ data: DetailMovieModel)
    func showLoadingView(_ toggle: Bool)
    func showErrorView(_ error: ApiError)
    func hideErrorView()
}

protocol DetailMoviePresenterDelegate: AnyObject {
    
    func viewDidLoad()
    func getMovieDetail()
    func backToDiscover() 
    func pushToYoutubeWith(_ key: String)
    func pushToReview(_ movieId: Int)
}

protocol DetailMovieRouterDelegate: AnyObject {
    
    func backToDiscover()
    func pushToReview(_ movieId: Int)
}

protocol DetailMovieInteractorInputDelegate: AnyObject {
    
    func getMovieDetail(_ movieId: Int)
    
}

protocol DetailMovieInteractorOutputDelegate: AnyObject {
    func successGetMovieDetail(_ response: ApiResponse<DetailMovieModel>)
    func failedGetMovieDetail(_ error: ApiError)
}
