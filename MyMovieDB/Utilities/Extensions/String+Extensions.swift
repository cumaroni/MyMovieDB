//
//  String+Extensions.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import Foundation

extension String {
    
    func convertToFormattedDate(fromFormat: String, toFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
}
