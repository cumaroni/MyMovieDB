//
//  ReviewListModel.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import SwiftyJSON

struct ReviewListModel: ApiModel {
     
    var authorName: String
    var authorPhoto: String
    var rating: Double
    var reviews: String
    var date: String
    
    init(json: JSON) {
        authorName = json["author"].stringValue
        authorPhoto = json["author_details"]["avatar_path"].stringValue
        rating = json["author_details"]["rating"].doubleValue
        reviews = json["content"].stringValue
        date = json["updated_at"].stringValue
    }
    
}
