//
//  DetailMovieRemote.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import Alamofire

class DetailMovieRemote: DetailMovieRequestProtocol {
    
    weak var dataManager: DetailMovieResponseProtocol?
    var api: API<DetailMovieModel> = API<DetailMovieModel>()
    
    func getMovieDetail(by movieId: Int, params: Parameters) {
        let data = ApiRequest(
            path: "movie/\(movieId)",
            method: .get,
            params: params
        )
        guard let dataManager = dataManager else { return }
        api.request(
            data,
            onSuccess: dataManager.successGetMovieDetail,
            onError: dataManager.failedGetMovieDetail
        )
    }
     
}
