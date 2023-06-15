//
//  HomeDMProtocol.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import Alamofire

protocol HomeRequestProtocol: AnyObject {
    var dataManager: HomeResponseProtocol? { get set }
    var genreApi: API<GenreListModel> { get set }
    var moviesByGenreApi: API<MoviesListModel> { get set }
    
    func getGenreList(params: Parameters)
    func getMoviesByGenre(params: Parameters)
}

protocol HomeResponseProtocol: AnyObject {
    func successGetGenreList(_ response: ApiResponse<GenreListModel>)
    func failedGetGenreList(_ error: ApiError)
    
    func successGetMovieList(_ response: ApiResponse<MoviesListModel>)
    func failedGetMovieList(_ error: ApiError)
}

protocol HomeDMRequestProtocol: AnyObject {
    var interactor: HomeResponseProtocol? { get set }
    var remote: HomeRequestProtocol { get set }
    
    init(_ interactor: HomeResponseProtocol)
    
    func getGenreList()
    func getMoviesByGenre(_ id: Int, _ page: Int)
}
