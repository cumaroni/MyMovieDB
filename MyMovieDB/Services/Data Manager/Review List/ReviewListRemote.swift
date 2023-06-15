//
//  ReviewListRemote.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import Alamofire

class ReviewListRemote: ReviewListRequestProtocol {
    
    weak var dataManager: ReviewListResponseProtocol?
    var api: API<ReviewListModel> = API<ReviewListModel>()
    
    func getReviewList(_ movieId: Int, _ params: Parameters) {
        let data = ApiRequest(
            path: "movie/\(movieId)/reviews",
            method: .get,
            params: params
        )
        guard let dataManager = dataManager else { return }
        api.request(
            data,
            onSuccess: dataManager.successGetReviewList,
            onError: dataManager.failedGetReviewList
        )
    }
}
