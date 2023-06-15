//
//  ApiModel.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import SwiftyJSON

public protocol ApiModel { 
    init(json: JSON)
}
