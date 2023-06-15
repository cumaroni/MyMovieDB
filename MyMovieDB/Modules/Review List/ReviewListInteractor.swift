//
//  ReviewListInteractor.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import Foundation

final class ReviewListInteractor {
    weak var presenter: ReviewListInteractorOutputDelegate? 
    private var reviewListDM: ReviewListDMRequestProtocol?
    var isLoadingData: Bool = false
    
    init(presenter: ReviewListInteractorOutputDelegate?) {
        self.presenter = presenter
        reviewListDM = ReviewListDataManager(self)
    }
    
}

extension ReviewListInteractor: ReviewListInteractorInputDelegate {
    
    func getReviewList(_ movieId: Int, _ page: Int) {
        isLoadingData = true
        reviewListDM?.getReviewList(movieId, page)
    }
}


extension ReviewListInteractor: ReviewListResponseProtocol {
    
    func successGetReviewList(_ response: ApiResponse<ReviewListModel>) {
        isLoadingData = false
        presenter?.successGetReviewList(response)
    }
     
    func failedGetReviewList(_ error: ApiError) {
        isLoadingData = false
        presenter?.failedGetReviewList(error)
    }
}
