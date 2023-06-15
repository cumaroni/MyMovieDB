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
    
    func selectFirstGenreCell() {
        let indexPath = IndexPath(item: 0, section: 0)
        view?.selectCell(at: indexPath)
    }
}

extension HomePresenter: HomePresenterDelegate {
    
    func viewDidLoad() {
        interactor.getGenreList()
    }
    
    func isLoading() -> Bool {
        return interactor.isLoadingData
    }
    
    func didSelectGenre(id: Int, at index: IndexPath, isRefresh: Bool) {
        if !isRefresh && selectedGenreIndex == index {
            return
        }
        selectedGenreIndex = index
        view?.reloadCollectionView()
        view?.showLoadingView(true)
        self.interactor.getMovieListByGenre(id: id, page: 1)
    }
    
    func selectFirstCell() {
        let indexPath = IndexPath(item: 0, section: 0)
        didSelectGenre(id: view?.getFirstGenreIndexId() ?? 0, at: indexPath, isRefresh: false)
    }
    
    func loadNextMoviePage(id: Int) {
        guard !interactor.isLoadingData else { return }
        currentPage += 1
        view?.showLoadingView(true)
        self.interactor.getMovieListByGenre(id: id, page: currentPage)
    }
    
}

extension HomePresenter: HomeInteractorOutputDelegate {
    
    func successGetGenreList(_ response: ApiResponse<GenreListModel>) {
        let data = response.JSONResponse["genres"].arrayValue
        var genreData: [GenreListModel] = []
        for genreJSON in data {
            genreData.append(GenreListModel(json: genreJSON))
        }
        self.view?.setGenreListData(genreData)
        view?.reloadCollectionView()
        
    }
    
    func failedGetGenreList(_ error: ApiError) {
        print("FAILED GET GENRE LIST, MESSAGE: \(error.messages)")
    }
    
    func successGetMovieList(_ response: ApiResponse<MoviesListModel>) {
        self.view?.setMovieListData(response.data)
        self.interactor.isLoadingData = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { 
            self.view?.showLoadingView(false)
            self.view?.reloadTblView()
        }
    }
    
    func failedGetMovieList(_ error: ApiError) {
        self.interactor.isLoadingData = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view?.showLoadingView(false)
        }
        print("FAILED GET MOVIE LIST, MESSAGE: \(error.messages)")
    }
    
    
}
