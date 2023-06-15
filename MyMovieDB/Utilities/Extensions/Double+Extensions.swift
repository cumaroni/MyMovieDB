//
//  Double+Extensions.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import Foundation

extension Double {
    
    func convertToCurrencyWith(symbol: String) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = symbol
        return numberFormatter.string(from: NSNumber(value: self))
    }
}
