//
//  DataManager.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 12.05.2023.
//

import Foundation
class DataManager {
    static let shared = DataManager()
    static var uniqueRegions = [String]()
    
    func getCountriesInRegion(_ region: String) -> [(countryName: String, cca2: String, capital: [String]?, flags: String, isExpanded : Bool)] {
        return APIManager.shared.countryData.filter { $0.region == region }.map { (countryName: $0.name.common, cca2: $0.cca2, capital: $0.capital, flags: $0.flags.png, false)}
    }
    
}


