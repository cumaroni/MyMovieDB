//
//  VideoTrailersModel.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import SwiftyJSON

struct VideoTrailers: ApiModel {
    
    var key: String
    
    init(json: JSON) {
        key = json["key"].stringValue
    }
    
}
