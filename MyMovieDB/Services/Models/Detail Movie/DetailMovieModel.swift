//
//  DetailMovieModel.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import SwiftyJSON

struct DetailMovieModel: ApiModel {
    
    var id: Int
    var backdropPath: String
    var genres: [GenreListModel] = []
    var title: String
    var originalTitle: String
    var originalLang: String
    var overview: String
    var posterPath: String
    var releaseDate: String
    var revenue: Double
    var status: String
    var vote: Double
    var trailers: [VideoTrailers] = []
    
    init(json: JSON) {
        id = json["id"].intValue
        backdropPath = json["backdrop_path"].stringValue
        genres = json["genres"].arrayValue.map({ element in
            return GenreListModel(json: element)
        })
        title = json["title"].stringValue
        originalTitle = json["original_title"].stringValue
        originalLang = json["original_language"].stringValue
        overview = json["overview"].stringValue
        posterPath = json["poster_path"].stringValue
        releaseDate = json["release_date"].stringValue
        revenue = json["revenue"].doubleValue
        status = json["status"].stringValue
        vote = json["vote_average"].doubleValue
        trailers = json["videos"]["results"].arrayValue.map({ element in
            return VideoTrailers(json: element)
        })
    }
    
}
