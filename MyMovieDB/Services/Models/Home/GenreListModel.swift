//
//  GenreListModel.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import SwiftyJSON

struct GenreListModel: ApiModel {
    
    var id: Int
    var name: String
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
    }
    
}
