//
//  MoviesListModel.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import SwiftyJSON

struct MoviesListModel: ApiModel {
     
    var backgroundPath: String
    var id: Int
    var overview: String
    var posterPath: String
    var title: String
    
    
    init(json: JSON) {
        backgroundPath = json["backdrop_path"].stringValue
        id = json["id"].intValue
        overview = json["overview"].stringValue
        posterPath = json["poster_path"].stringValue
        title = json["title"].stringValue
    }
    
}
