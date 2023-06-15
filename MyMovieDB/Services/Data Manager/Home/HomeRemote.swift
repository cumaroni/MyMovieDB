//
//  HomeRemote.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import Alamofire

class HomeRemote: HomeRequestProtocol {
    
    weak var dataManager: HomeResponseProtocol?
    var genreApi: API<GenreListModel> = API<GenreListModel>()
    var moviesByGenreApi: API<MoviesListModel> = API<MoviesListModel>()
    
    func getGenreList(params: Parameters) {
        let data = ApiRequest(
            path: "genre/movie/list",
            method: .get,
            params: params
        )
        guard let dataManager = dataManager else { return }
        genreApi.request(
            data,
            onSuccess: dataManager.successGetGenreList,
            onError: dataManager.failedGetGenreList
        )
    }
    
    func getMoviesByGenre(params: Parameters) {
        let data = ApiRequest(
            path: "discover/movie",
            method: .get,
            params: params
        )
        guard let dataManager = dataManager else { return }
        moviesByGenreApi.request(
            data,
            onSuccess: dataManager.successGetMovieList,
            onError: dataManager.failedGetMovieList
        )
    }
}
