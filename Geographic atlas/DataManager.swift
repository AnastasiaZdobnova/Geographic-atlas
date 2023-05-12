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
    
    func getCountriesInRegion(_ region: String) -> [String] {
        return APIManager.shared.countryData.filter { $0.region == region }.map { $0.name.common }
    }
    
}
