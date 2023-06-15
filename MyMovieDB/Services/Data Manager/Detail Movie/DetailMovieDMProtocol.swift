//
//  DetailMovieDMProtocol.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import Alamofire

protocol DetailMovieRequestProtocol: AnyObject {
    var dataManager: DetailMovieResponseProtocol? { get set }
    var api: API<DetailMovieModel> { get set }
    
    func getMovieDetail(by movieId: Int, params: Parameters)
}

protocol DetailMovieResponseProtocol: AnyObject {
    func successGetMovieDetail(_ response: ApiResponse<DetailMovieModel>)
    func failedGetMovieDetail(_ error: ApiError)
}

protocol DetailMovieDMRequestProtocol: AnyObject {
    var interactor: DetailMovieResponseProtocol? { get set }
    var remote: DetailMovieRequestProtocol { get set }
    
    init(_ interactor: DetailMovieResponseProtocol)
    
    func getMovieDetail(by movieId: Int) 
}
