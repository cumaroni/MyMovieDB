//
//  DetailMovieDataManager.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//


import Alamofire

class DetailMovieDataManager: DetailMovieDMRequestProtocol {
    
    weak var interactor: DetailMovieResponseProtocol? = nil
    var remote: DetailMovieRequestProtocol
    
    required init(_ interactor: DetailMovieResponseProtocol) {
        self.interactor = interactor
        remote = DetailMovieRemote()
        remote.dataManager = self
    }
    
    func getMovieDetail(by movieId: Int) {
        var params: Parameters = [:]
        params["api_key"] = "99c5162c8ce328fe88076080efe171c3"
        params["language"] = "en-US"
        params["append_to_response"] = "videos"
        remote.getMovieDetail(by: movieId, params: params)
    }
    
}

extension DetailMovieDataManager: DetailMovieResponseProtocol {
    
    func successGetMovieDetail(_ response: ApiResponse<DetailMovieModel>) {
        interactor?.successGetMovieDetail(response)
    }
    
    func failedGetMovieDetail(_ error: ApiError) {
        interactor?.failedGetMovieDetail(error)
    }
    
    
}
