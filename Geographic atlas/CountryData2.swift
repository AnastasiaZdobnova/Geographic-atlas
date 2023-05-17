//
//  CountryData2.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 17.05.2023.
//

import Foundation

// MARK: - CountryData
struct CountryDatum2: Codable {
    let name: Name
    let cca2: String
    let currencies: [String: Currency]?
    let capital: [String]
    let region: String
    let area: Double
    let flag: String
    //let maps: Maps
    let population: Int
    //let timezones: [String]
    let flags: Flags
    //let capitalInfo: CapitalInfo
}

//name,cca2,currencies,capital,region,area,flag,maps,population,timezones,flags,capitalInfo

// MARK: - CapitalInfo
//struct CapitalInfo: Codable {
//    let latlng: [Double]?
//}

// MARK: - Currencies
struct Currency: Codable {
    let name: String
    let symbol: String?
}



// MARK: - Flags
struct Flags: Codable {
    let png: String
    let svg: String
    let alt: String?
}

// MARK: - Maps
//struct Maps: Codable {
//    let googleMaps, openStreetMaps: String
//}

// MARK: - Name
struct Name: Codable {
    let common, official: String
    let nativeName: [String: Translation]?
}

struct Translation: Codable {
    let official, common: String
}


typealias CountryData2 = [CountryDatum2]
