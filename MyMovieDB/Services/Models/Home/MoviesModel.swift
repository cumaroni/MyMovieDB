//
//  MoviesModel.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import SwiftyJSON

struct MoviesModel: ApiModel {
    
    var page: Int
    var results: [MoviesListModel] = []
    var totalPages: Int
    var totalResults: Int
    
    init(json: JSON) {
        page = json["page"].intValue
        results = json["results"].arrayValue.map({ element in
            return MoviesListModel(json: element)
        })
        totalPages = json["total_pages"].intValue
        totalResults = json["total_results"].intValue
    }
    
}
