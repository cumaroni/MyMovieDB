//
//  HomeDataManager.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import Alamofire

class HomeDataManager: HomeDMRequestProtocol {
    
    weak var interactor: HomeResponseProtocol? = nil
    var remote: HomeRequestProtocol
    
    required init(_ interactor: HomeResponseProtocol) {
        self.interactor = interactor
        remote = HomeRemote()
        remote.dataManager = self
    }
    
    func getGenreList() {
        var params: Parameters = [:]
        params["api_key"] = "99c5162c8ce328fe88076080efe171c3"
        params["language"] = "en-US"
        remote.getGenreList(params: params)
    }
    
    func getMoviesByGenre(_ id: Int, _ page: Int) {
        var params: Parameters = [:]
        params["api_key"] = "99c5162c8ce328fe88076080efe171c3"
        params["language"] = "en-US"
        params["include_adult"] = false
        params["include_video"] = false
        params["sort_by"] = "popularity.desc"
        params["with_genres"] = id
        params["page"] = page
        remote.getMoviesByGenre(params: params)
    }
}

extension HomeDataManager: HomeResponseProtocol {
    
    func successGetGenreList(_ response: ApiResponse<GenreListModel>) {
        interactor?.successGetGenreList(response)
    }
    
    func failedGetGenreList(_ error: ApiError) {
        interactor?.failedGetGenreList(error)
    }
    
    func successGetMovieList(_ response: ApiResponse<MoviesListModel>) {
        interactor?.successGetMovieList(response)
    }
    
    func failedGetMovieList(_ error: ApiError) {
        interactor?.failedGetMovieList(error)
    }
    
     
    
}
