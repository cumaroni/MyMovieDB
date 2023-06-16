//
//  HomePresenter.swift
//  MyMovieDB
//
//  Created by Roni Doang on 13/06/23.
//

import Foundation
 
final class HomePresenter {
    weak var view: HomeViewControllerDelegate?
    lazy var router: HomeRouterDelegate = HomeRouter(view: view)
    lazy var interactor: HomeInteractorInputDelegate = HomeInteractor(presenter: self)
    
    private var selectedGenreIndex: IndexPath?
    private var currentPage: Int = 1
    
    init(view: HomeViewControllerDelegate?) {
        self.view = view
    }
    
    func getSelectedGenreIndex() -> IndexPath? {
        return selectedGenreIndex
    }
}

extension HomePresenter: HomePresenterDelegate {
    
    func viewDidLoad() {
        getGenreList()
    }
    
    func getGenreList() {
        interactor.getGenreList()
    }
    
    func didSelectGenre(id: Int, at index: IndexPath, isRefresh: Bool) {
        if !isRefresh && selectedGenreIndex == index { return }
        selectedGenreIndex = index
        view?.reloadCollectionView()
        view?.showLoadingView(true)
        view?.removeAllMovieData()
        self.interactor.getMovieListByGenre(id: id, page: 1)
    }
    
    func selectGenreCell() {
        let indexPath = IndexPath(item: 0, section: 0)
        didSelectGenre(id: view?.getFirstGenreIndexId() ?? 0, at: indexPath, isRefresh: false)
    }
    
    func loadNextMoviePage(id: Int) { 
        currentPage += 1
        view?.showLoadingView(true)
        self.interactor.getMovieListByGenre(id: id, page: currentPage)
    }
    
    func pushToMovieDetail(_ movieId: Int) {
        router.pushToMovieDetail(movieId)
    }
    
}

extension HomePresenter: HomeInteractorOutputDelegate {
    
    func successGetGenreList(_ response: ApiResponse<GenreListModel>) {
        let data = response.JSONResponse["genres"].arrayValue
        var genreData: [GenreListModel] = []
        for genreJSON in data {
            genreData.append(GenreListModel(json: genreJSON))
        }
        view?.setGenreListData(genreData)
        view?.reloadCollectionView()
        view?.hideError()
    }
    
    func failedGetGenreList(_ error: ApiError) {
        view?.showGenreErrorView(error)
    }
    
    func successGetMovieList(_ response: ApiResponse<MoviesListModel>) { 
        view?.setMovieListData(response.data, totalResult: response.totalResult)
        view?.reloadTblView()
        view?.hideError()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { 
            self.view?.showLoadingView(false) 
        }
    }
    
    func failedGetMovieList(_ error: ApiError) {
        view?.showMovieErrorView(error)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view?.showLoadingView(false)
        }
    }
    
    
}
