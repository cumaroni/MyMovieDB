//
//  DetailMovieViewController.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//
import UIKit
import Kingfisher
import SkeletonView

class DetailMovieViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var dateAndGenreLbl: UILabel!
    @IBOutlet weak var voteView: UIView!
    @IBOutlet weak var voteLbl: UILabel!
    @IBOutlet weak var langView: UIView!
    @IBOutlet weak var langLbl: UILabel!
    @IBOutlet weak var statusValueLbl: UILabel!
    @IBOutlet weak var revenueValueLbl: UILabel!
    @IBOutlet weak var originalTitleValueLbl: UILabel!
    @IBOutlet weak var overviewValueLbl: UILabel!
    @IBOutlet weak var trailersCollection: UICollectionView!
    
    lazy var presenter: DetailMoviePresenterDelegate = DetailMoviePresenter(view: self)
    
    var movieId: Int = 0
    private var movieDetailModel: DetailMovieModel?
    private var trailersData: [VideoTrailers] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter.viewDidLoad()
    }
    
    private func setupView() {
        posterView.layer.cornerRadius = 6
        posterView.layer.masksToBounds = false
        posterView.layer.shadowColor = UIColor.black.cgColor
        posterView.layer.shadowOpacity = 0.8
        posterView.layer.shadowOffset = CGSize(width: 2, height: 2)
        posterView.layer.shadowRadius = 2
        
        voteView.layer.cornerRadius = voteView.frame.width / 2
        voteView.layer.borderColor = UIColor.midnightBlue.cgColor
        voteView.layer.borderWidth = 1
        
        langView.layer.cornerRadius = 2
        langView.layer.borderColor = UIColor.midnightBlue.cgColor
        langView.layer.borderWidth = 1
        
        let nib = UINib(nibName: "VideoTrailersCell", bundle: nil)
        trailersCollection.register(nib, forCellWithReuseIdentifier: "cell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 200, height: 150)
        trailersCollection.setCollectionViewLayout(layout, animated: true)
    }
    
    private func setupDetailModel() {
        guard let model = movieDetailModel else { return }
        
        if let bgImageUrl = URL(
            string: "https://image.tmdb.org/t/p/w500\(model.backdropPath)") {
            backgroundImg.kf.setImage(with: bgImageUrl, placeholder: UIImage(named: "icDownloadImg"))
        } else {
            backgroundImg.image = UIImage(named: "icEmptyImg")
        }
        
        if let posterImgUrl = URL(
            string: "https://image.tmdb.org/t/p/w500\(model.posterPath)") {
            posterImg.kf.setImage(with: posterImgUrl)
        } else {
            posterImg.image = UIImage(named: "icEmptyImg")
        }
        
        titleLbl.text = model.title
        let year = String(model.releaseDate.prefix(4))
        let genres = model.genres.map { $0.name }
        let joinedGenres = genres.joined(separator: ", ")
        dateAndGenreLbl.text = "\(year), \(joinedGenres)"
        let vote = model.vote
        let roundedVote = (vote * 10).rounded() / 10
        voteLbl.text = "\(roundedVote)"
        langLbl.text = model.originalLang.uppercased()
        statusValueLbl.text = model.status
        revenueValueLbl.text = model.revenue.convertToCurrencyWith(symbol: "$")
        originalTitleValueLbl.text = model.originalTitle
        overviewValueLbl.text = model.overview
        trailersData = model.trailers
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        presenter.backToDiscover()
    }
    
    @IBAction func readAllBtnPressed(_ sender: Any) {
        presenter.pushToReview(movieDetailModel?.id ?? 0)
    }
    
}

extension DetailMovieViewController: DetailMovieViewControllerDelegate {
    
    func setDetailMovieData(_ data: DetailMovieModel) {
        movieDetailModel = data
        setupDetailModel()
        trailersCollection.reloadData()
    }
    
    func showLoadingView(_ toggle: Bool) {
        if toggle {
            self.contentView.showAnimatedSkeleton()
        } else {
            self.contentView.hideSkeleton()
        }
    }
    
}

extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection
        section: Int
    ) -> Int {
        return trailersData.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideoTrailersCell
        cell.configureCell(with: trailersData[indexPath.row].key)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.pushToYoutubeWith(trailersData[indexPath.row].key)
    }
    
    
}
