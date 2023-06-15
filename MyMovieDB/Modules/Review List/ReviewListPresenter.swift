//
//  ReviewListPresenter.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import UIKit

final class ReviewListPresenter {
    weak var view: ReviewListViewControllerDelegate?
    lazy var router: ReviewListRouterDelegate = ReviewListRouter(view: view)
    lazy var interactor: ReviewListInteractorInputDelegate = ReviewListInteractor(presenter: self)
    
    private var currentPage: Int = 1
    
    init(view: ReviewListViewControllerDelegate?) {
        self.view = view
    }
}

extension ReviewListPresenter: ReviewListPresenterDelegate {
    
    func viewDidLoad() {
        view?.showLoadingView(true)
        interactor.getReviewList(view?.movieId ?? 0, currentPage)
    }
    
    func backToMovieDetail() {
        router.backToMovieDetail()
    }
    
    func loadNextReviewPage(id: Int) {
        guard !interactor.isLoadingData else { return }
        currentPage += 1
        view?.showLoadingView(true)
        interactor.getReviewList(view?.movieId ?? 0, currentPage)
    }
}

extension ReviewListPresenter: ReviewListInteractorOutputDelegate {
    
    func successGetReviewList(_ response: ApiResponse<ReviewListModel>) {
        view?.setReviewListData(response.data, totalResult: response.totalResult)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view?.showLoadingView(false)
        }
    }
    
    func failedGetReviewList(_ error: ApiError) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view?.showLoadingView(false)
        }
        print("FAILED GET REVIEW LIST, MESSAGE: \(error.messages)")
    }
    
    
}
