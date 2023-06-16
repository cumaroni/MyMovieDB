//
//  DetailMoviePresenter.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import UIKit

final class DetailMoviePresenter {
    weak var view: DetailMovieViewControllerDelegate?
    lazy var router: DetailMovieRouterDelegate = DetailMovieRouter(view: view)
    lazy var interactor: DetailMovieInteractorInputDelegate = DetailMovieInteractor(presenter: self)
    
    init(view: DetailMovieViewControllerDelegate?) {
        self.view = view
    }
}

extension DetailMoviePresenter: DetailMoviePresenterDelegate {
    
    func viewDidLoad() {
        getMovieDetail()
    }
    
    func getMovieDetail() {
        view?.showLoadingView(true)
        interactor.getMovieDetail(view?.movieId ?? 0)
    }
    
    func backToDiscover() {
        router.backToDiscover()
    }
    
    func pushToYoutubeWith(_ key: String) {
        let appURL = URL(string: "youtube://\(key)") // YouTube app URL scheme
        let webURL = URL(string: "https://www.youtube.com/watch?v=\(key)") // YouTube website URL

        if UIApplication.shared.canOpenURL(appURL!) {
            UIApplication.shared.open(appURL!, options: [:], completionHandler: nil) // Open in YouTube app
        } else {
            UIApplication.shared.open(webURL!, options: [:], completionHandler: nil) // Open in browser
        }
    }
    
    func pushToReview(_ movieId: Int) {
        router.pushToReview(movieId)
    }
}

extension DetailMoviePresenter: DetailMovieInteractorOutputDelegate {
    
    func successGetMovieDetail(_ response: ApiResponse<DetailMovieModel>) {
        view?.hideErrorView()
        view?.setDetailMovieData(response.model)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view?.showLoadingView(false)
        }
    }
    
    func failedGetMovieDetail(_ error: ApiError) {
        view?.showErrorView(error)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view?.showLoadingView(false)
        }
    }
    
    
}
