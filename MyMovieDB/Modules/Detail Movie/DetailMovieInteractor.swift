//
//  DetailMovieInteractor.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import Foundation

final class DetailMovieInteractor {
    weak var presenter: DetailMovieInteractorOutputDelegate?
    private var detailMovieDM: DetailMovieDMRequestProtocol?
    
    init(presenter: DetailMovieInteractorOutputDelegate?) {
        self.presenter = presenter
        detailMovieDM = DetailMovieDataManager(self)
    }
    
}

extension DetailMovieInteractor: DetailMovieInteractorInputDelegate {
    
    func getMovieDetail(_ movieId: Int) {
        detailMovieDM?.getMovieDetail(by: movieId)
    }
}


extension DetailMovieInteractor: DetailMovieResponseProtocol {
    
    func successGetMovieDetail(_ response: ApiResponse<DetailMovieModel>) {
        presenter?.successGetMovieDetail(response)
    }
     
    func failedGetMovieDetail(_ error: ApiError) {
        presenter?.failedGetMovieDetail(error)
    }
}
