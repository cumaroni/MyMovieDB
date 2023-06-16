//
//  HomeViewController.swift
//  MyMovieDB
//
//  Created by Roni Doang on 13/06/23.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var errorView: UIStackView!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var genreListCollection: UICollectionView!
    @IBOutlet weak var moviesTblView: UITableView!
    
    lazy var presenter: HomePresenterDelegate = HomePresenter(view: self)
    
    var genreListData: [GenreListModel] = []
    var movieListData: [MoviesListModel] = []
    private var totalResult: Int = 0
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        setupView()
        presenter.viewDidLoad()
    }   
    
    private func setupView() {
        setupCollectionView()
        setupTblView()
    }
    
    private func setupCollectionView() {
        let nib = UINib(nibName: "GenreListCell", bundle: nil)
        genreListCollection.register(nib, forCellWithReuseIdentifier: "genreCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = CGSize(
            width: 10, height: 10
        )
        genreListCollection.setCollectionViewLayout(layout, animated: true)
    }
    
    private func setupTblView() {
        let nib = UINib(nibName: "MovieListCell", bundle: nil)
        moviesTblView.register(nib, forCellReuseIdentifier: "movieCell")
        moviesTblView.tableFooterView = UIView()
        moviesTblView.rowHeight = UITableView.automaticDimension
        moviesTblView.estimatedRowHeight = 44
        moviesTblView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    @objc func pullToRefresh() {
        requestMovieList()
    }
    
    @IBAction func retryBtnPressed(_ sender: Any) {
        if genreListCollection.isHidden == true {
            presenter.getGenreList()
        } else {
            requestMovieList()
        }
    }
    
    private func requestMovieList() {
        self.movieListData.removeAll()
        let index = presenter.getSelectedGenreIndex() ?? IndexPath(row: 0, section: 0)
        presenter.didSelectGenre(
            id: genreListData[index.row].id,
            at: index,
            isRefresh: true
        )
    }
    
}

extension HomeViewController: HomeViewControllerDelegate {
    
    func setGenreListData(_ data: [GenreListModel]) {
        genreListData = data
        presenter.selectGenreCell()
    }
    
    func setMovieListData(_ data: [MoviesListModel], totalResult: Int) {
        movieListData += data
        self.totalResult = totalResult
    }
    
    func reloadCollectionView() {
        genreListCollection.reloadData()
    }
    
    func getFirstGenreIndexId() -> Int {
        return genreListData[0].id
    }
    
    func removeAllMovieData() {
        movieListData.removeAll()
    }
    
    func reloadTblView() {
        moviesTblView.reloadData() 
        refreshControl.endRefreshing()
    }
    
    func showLoadingView(_ toggle: Bool) {
        if toggle == true {
            self.moviesTblView.showLoadingView()
        } else {
            self.moviesTblView.hideLoadingVIew()
        }
    }
    
    func showMovieErrorView(_ error: ApiError) {
        errorLbl.text = error.messages
        moviesTblView.isHidden = true
        errorView.isHidden = false
    }
    
    func showGenreErrorView(_ error: ApiError) {
        errorLbl.text = error.messages
        genreListCollection.isHidden = true
        moviesTblView.isHidden = true
        errorView.isHidden = false
    }
    
    func hideError() {
        genreListCollection.isHidden = false
        moviesTblView.isHidden = false
        errorView.isHidden = true
    }
    
}

//GENRE LIST
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int { 
        return genreListData.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "genreCell",
            for: indexPath
        ) as! GenreListCell
        let isSelected = indexPath == presenter.getSelectedGenreIndex()
        cell.configureCell(with: genreListData[indexPath.row])
        cell.setSelected(isSelected) 
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if !movieListData.isEmpty {
            moviesTblView.scrollToRow(
                at: IndexPath(row: 0, section: 0),
                at: .top, animated: true
            )
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.presenter.didSelectGenre(
                id: self.genreListData[indexPath.row].id,
                at: indexPath,
                isRefresh: false
            )
        }
    }
}

//MOVIE LIST
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return movieListData.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "movieCell"
        ) as! MovieListCell
        cell.configureCell(with: movieListData[indexPath.row])
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        let lastSection = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
        
        if indexPath.section == lastSection && indexPath.row == lastRow { 
            if totalResult == movieListData.count { return }
            let index = presenter.getSelectedGenreIndex() ?? IndexPath(row: 0, section: 0)
            presenter.loadNextMoviePage(id: genreListData[index.row].id)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = movieListData[indexPath.row].id
        presenter.pushToMovieDetail(movieId)
    }
    
}
