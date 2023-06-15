//
//  ReviewListDMProtocol.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import Alamofire

protocol ReviewListRequestProtocol: AnyObject {
    var dataManager: ReviewListResponseProtocol? { get set }
    var api: API<ReviewListModel> { get set }
    
    func getReviewList(_ movieId: Int, _ params: Parameters)
}

protocol ReviewListResponseProtocol: AnyObject {
    func successGetReviewList(_ response: ApiResponse<ReviewListModel>)
    func failedGetReviewList(_ error: ApiError)
}

protocol ReviewListDMRequestProtocol: AnyObject {
    var interactor: ReviewListResponseProtocol? { get set }
    var remote: ReviewListRequestProtocol { get set }
    
    init(_ interactor: ReviewListResponseProtocol)
     
    func getReviewList(_ movieId: Int, _ page: Int)
}
