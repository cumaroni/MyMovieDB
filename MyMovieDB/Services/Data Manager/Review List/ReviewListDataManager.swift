//
//  ReviewListDataManager.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import Alamofire

class ReviewListDataManager: ReviewListDMRequestProtocol {
    
    weak var interactor: ReviewListResponseProtocol? = nil
    var remote: ReviewListRequestProtocol
    
    required init(_ interactor: ReviewListResponseProtocol) {
        self.interactor = interactor
        remote = ReviewListRemote()
        remote.dataManager = self
    }
    
    func getReviewList(_ movieId: Int, _ page: Int) {
        var params: Parameters = [:]
        params["api_key"] = "99c5162c8ce328fe88076080efe171c3"
        params["language"] = "en-US"
        params["page"] = page
        remote.getReviewList(movieId, params)
    }
}

extension ReviewListDataManager: ReviewListResponseProtocol {
    
    func successGetReviewList(_ response: ApiResponse<ReviewListModel>) {
        interactor?.successGetReviewList(response)
    }
    
    func failedGetReviewList(_ error: ApiError) {
        interactor?.failedGetReviewList(error)
    } 
}
