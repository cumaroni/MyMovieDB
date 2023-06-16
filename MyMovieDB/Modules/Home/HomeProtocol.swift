//
//  HomeProtocol.swift
//  MyMovieDB
//
//  Created by Roni Doang on 13/06/23.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func setGenreListData(_ data: [GenreListModel])
    func setMovieListData(_ data: [MoviesListModel], totalResult: Int)
    func reloadCollectionView() 
    func removeAllMovieData()
    func getFirstGenreIndexId() -> Int
    func reloadTblView()
    func showLoadingView(_ toggle: Bool)
    func showGenreErrorView(_ error: ApiError)
    func showMovieErrorView(_ error: ApiError)
    func hideError()
}

protocol HomePresenterDelegate: AnyObject {
    
    func viewDidLoad()
    func getGenreList() 
    func didSelectGenre(id: Int, at index: IndexPath, isRefresh: Bool)
    func getSelectedGenreIndex() -> IndexPath?
    func selectGenreCell()
    func loadNextMoviePage(id: Int)
    
    func pushToMovieDetail(_ movieId: Int)
}

protocol HomeRouterDelegate: AnyObject {
    
    func pushToMovieDetail(_ movieId: Int)
}

protocol HomeInteractorInputDelegate: AnyObject {
     
    func getGenreList()
    func getMovieListByGenre(id: Int, page: Int)
    
}

protocol HomeInteractorOutputDelegate: AnyObject { 
    func successGetGenreList(_ response: ApiResponse<GenreListModel>)
    func failedGetGenreList(_ error: ApiError)
    
    func successGetMovieList(_ response: ApiResponse<MoviesListModel>)
    func failedGetMovieList(_ error: ApiError)
    
}
