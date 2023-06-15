//
//  HomeInteractor.swift
//  MyMovieDB
//
//  Created by Roni Doang on 13/06/23.
//

import Foundation

final class HomeInteractor: HomeResponseProtocol {
    weak var presenter: HomeInteractorOutputDelegate?
    
    private var homeDM: HomeDMRequestProtocol?
    var isLoadingData: Bool = false
    
    init(presenter: HomeInteractorOutputDelegate?) {
        self.presenter = presenter
        homeDM = HomeDataManager(self)
    }
    
}

extension HomeInteractor: HomeInteractorInputDelegate {
    
    func getGenreList() {
        homeDM?.getGenreList()
    }
    
    func getMovieListByGenre(id: Int, page: Int) {
        isLoadingData = true
        homeDM?.getMoviesByGenre(id, page)
    }
     
}


extension HomeInteractor: HomeInteractorOutputDelegate {
    
    func successGetGenreList(_ response: ApiResponse<GenreListModel>) {
        presenter?.successGetGenreList(response)
    }
    
    func failedGetGenreList(_ error: ApiError) {
        presenter?.failedGetGenreList(error)
    }
    
    func successGetMovieList(_ response: ApiResponse<MoviesListModel>) {
        presenter?.successGetMovieList(response)
    }
    
    func failedGetMovieList(_ error: ApiError) {
        presenter?.failedGetMovieList(error)
    }
    
    
}
