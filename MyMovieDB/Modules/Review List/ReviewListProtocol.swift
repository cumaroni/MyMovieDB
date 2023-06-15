//
//  ReviewListProtocol.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import UIKit

protocol ReviewTblCellProtocol: AnyObject {
    func configureCell(with data: ReviewListModel)
}
 
protocol ReviewListViewControllerDelegate: AnyObject {
    var movieId: Int { get }
    func setReviewListData(_ data: [ReviewListModel], totalResult: Int)
    func showLoadingView(_ toggle: Bool)
}

protocol ReviewListPresenterDelegate: AnyObject {
    
    func viewDidLoad()
    func backToMovieDetail()
    func loadNextReviewPage(id: Int)
}

protocol ReviewListRouterDelegate: AnyObject {
    
    func backToMovieDetail()
}

protocol ReviewListInteractorInputDelegate: AnyObject {
    
    var isLoadingData: Bool { get }
    func getReviewList(_ movieId: Int, _ page: Int)
}

protocol ReviewListInteractorOutputDelegate: AnyObject {
    func successGetReviewList(_ response: ApiResponse<ReviewListModel>)
    func failedGetReviewList(_ error: ApiError)
}

