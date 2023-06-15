//
//  ReviewListViewController.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import UIKit
import Kingfisher
import SkeletonView

class ReviewListViewController: UIViewController {
    
    @IBOutlet weak var reviewTblView: UITableView!
    
    lazy var presenter: ReviewListPresenterDelegate = ReviewListPresenter(view: self)
    
    var movieId: Int = 0 
    private var reviewListData: [ReviewListModel] = []
    private var totalResult: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter.viewDidLoad()
    }
    
    private func setupView() {
        let nib = UINib(nibName: "ReviewListCell", bundle: nil)
        reviewTblView.register(nib, forCellReuseIdentifier: "cell")
        reviewTblView.tableFooterView = UIView()
        reviewTblView.rowHeight = UITableView.automaticDimension
        reviewTblView.estimatedRowHeight = 44
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        presenter.backToMovieDetail()
    }
}

extension ReviewListViewController: ReviewListViewControllerDelegate {
    
    func setReviewListData(_ data: [ReviewListModel], totalResult: Int) {
        reviewListData += data
        reviewTblView.reloadData()
        self.totalResult = totalResult
        print(reviewListData.count)
    }
    
    func showLoadingView(_ toggle: Bool) {
        if toggle {
            self.reviewTblView.showAnimatedSkeleton()
        } else {
            self.reviewTblView.hideSkeleton()
        }
    }
    
}

extension ReviewListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return reviewListData.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ReviewListCell
        cell.configureCell(data: reviewListData[indexPath.row])
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
            if totalResult == reviewListData.count { return }
            presenter.loadNextReviewPage(id: movieId)
        }
    }
    
}
