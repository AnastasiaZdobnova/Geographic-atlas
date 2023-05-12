//
//  CountryData.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 12.05.2023.
//https://app.quicktype.io/

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let countryData = try? JSONDecoder().decode(CountryData.self, from: jsonData)

import Foundation

// MARK: - CountryDatum
struct CountryDatum: Codable {
    let name: Name
    let tld: [String]?
    let cca2: String
    let ccn3: String?
    let cca3: String
    let cioc: String?
    let independent: Bool?
    let status: Status
    let unMember: Bool
    let currencies: Currencies?
    let idd: Idd
    let capital: [String]?
    let altSpellings: [String]
    let region: String
    let subregion: String?
    let languages: [String: String]?
    let translations: [String: Translation]
    let latlng: [Double]
    let landlocked: Bool
    let borders: [String]?
    let area: Double
    let demonyms: Demonyms?
    let flag: String
    let maps: Maps
    let population: Int
    let gini: [String: Double]?
    let fifa: String?
    let car: Car
    let timezones: [String]
    let continents: [Continent]
    let flags: Flags
    let coatOfArms: CoatOfArms
    let startOfWeek: StartOfWeek
    let capitalInfo: CapitalInfo
    let postalCode: PostalCode?
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}

// MARK: - Car
struct Car: Codable {
    let signs: [String]?
    let side: Side
}

enum Side: String, Codable {
    case sideLeft = "left"
    case sideRight = "right"
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

// MARK: - Currencies
struct Currencies: Codable {
    let eur, afn: Aed?
    let sdg: BAM?
    let bgn, usd, pln, nzd: Aed?
    let tzs, mop, xof, czk: Aed?
    let ugx, ttd, dzd, uah: Aed?
    let mru, gel, ang, nad: Aed?
    let zar, mkd, mur, aud: Aed?
    let kid, xaf, qar, kyd: Aed?
    let bwp, egp, ils, jod: Aed?
    let vnd, gbp, jep, gyd: Aed?
    let tvd, pgk, bsd, cve: Aed?
    let omr, ves, bob, cad: Aed?
    let nok, kgs, amd, cdf: Aed?
    let chf, szl, dkk, fok: Aed?
    let ngn, mwk, stn, fkp: Aed?
    let gtq, bbd, ghs, nio: Aed?
    let imp, aoa, dop, all: Aed?
    let lyd, kwd, bhd, tmt: Aed?
    let lrd, rub, php, xcd: Aed?
    let ron, inr, mmk, bzd: Aed?
    let mnt, sar, huf, ars: Aed?
    let xpf, yer, sek, shp: Aed?
    let brl, ssp, thb, currenciesTRY: Aed?
    let bmd, bdt, sgd, mdl: Aed?
    let kes, uyu, byn, lbp: Aed?
    let btn, myr, kzt, tnd: Aed?
    let gmd, syp, gnf, mzn: Aed?
    let wst, twd, kpw, djf: Aed?
    let srd, rwf, krw, jmd: Aed?
    let mvr, pyg, idr, mga: Aed?
    let iqd, hnl, mad, hkd: Aed?
    let lkr, htg, cuc, cup: Aed?
    let tjs, ckd, cop, uzs: Aed?
    let gip, pen, pkr, clp: Aed?
    let zmw, scr, crc, kmf: Aed?
    let isk, jpy, fjd: Aed?
    let bam: BAM?
    let mxn, khr, irr, rsd: Aed?
    let aed, azn, vuv, ern: Aed?
    let npr, pab, ggp, sbd: Aed?
    let zwl, awg, bnd, lak: Aed?
    let top, lsl, sos, sll: Aed?
    let bif, etb, cny: Aed?

    enum CodingKeys: String, CodingKey {
        case eur
        case afn
        case sdg
        case bgn
        case usd
        case pln
        case nzd
        case tzs
        case mop
        case xof
        case czk
        case ugx
        case ttd
        case dzd
        case uah
        case mru
        case gel
        case ang
        case nad
        case zar
        case mkd
        case mur
        case aud
        case kid
        case xaf
        case qar
        case kyd
        case bwp
        case egp
        case ils
        case jod
        case vnd
        case gbp
        case jep
        case gyd
        case tvd
        case pgk
        case bsd
        case cve
        case omr
        case ves
        case bob
        case cad
        case nok
        case kgs
        case amd
        case cdf
        case chf
        case szl
        case dkk
        case fok
        case ngn
        case mwk
        case stn
        case fkp
        case gtq
        case bbd
        case ghs
        case nio
        case imp
        case aoa
        case dop
        case all
        case lyd
        case kwd
        case bhd
        case tmt
        case lrd
        case rub
        case php
        case xcd
        case ron
        case inr
        case mmk
        case bzd
        case mnt
        case sar
        case huf
        case ars
        case xpf
        case yer
        case sek
        case shp
        case brl
        case ssp
        case thb
        case currenciesTRY
        case bmd
        case bdt
        case sgd
        case mdl
        case kes
        case uyu
        case byn
        case lbp
        case btn
        case myr
        case kzt
        case tnd
        case gmd
        case syp
        case gnf
        case mzn
        case wst
        case twd
        case kpw
        case djf
        case srd
        case rwf
        case krw
        case jmd
        case mvr
        case pyg
        case idr
        case mga
        case iqd
        case hnl
        case mad
        case hkd
        case lkr
        case htg
        case cuc
        case cup
        case tjs
        case ckd
        case cop
        case uzs
        case gip
        case pen
        case pkr
        case clp
        case zmw
        case scr
        case crc
        case kmf
        case isk
        case jpy
        case fjd
        case bam
        case mxn
        case khr
        case irr
        case rsd
        case aed
        case azn
        case vuv
        case ern
        case npr
        case pab
        case ggp
        case sbd
        case zwl
        case awg
        case bnd
        case lak
        case top
        case lsl
        case sos
        case sll
        case bif
        case etb
        case cny
    }
}

// MARK: - Aed
struct Aed: Codable {
    let name, symbol: String
}

// MARK: - BAM
struct BAM: Codable {
    let name: String
}

// MARK: - Demonyms
struct Demonyms: Codable {
    let eng: Eng
    let fra: Eng?
}

// MARK: - Eng
struct Eng: Codable {
    let f, m: String
}

// MARK: - Flags
struct Flags: Codable {
    let png: String
    let svg: String
    let alt: String?
}

// MARK: - Idd
struct Idd: Codable {
    let root: String?
    let suffixes: [String]?
}

// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMaps: String
}

// MARK: - Name
struct Name: Codable {
    let common, official: String
    let nativeName: [String: Translation]?
}

// MARK: - Translation
struct Translation: Codable {
    let official, common: String
}

// MARK: - PostalCode
struct PostalCode: Codable {
    let format: String
    let regex: String?
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
}

enum StartOfWeek: String, Codable {
    case monday = "monday"
    case saturday = "saturday"
    case sunday = "sunday"
}

enum Status: String, Codable {
    case officiallyAssigned = "officially-assigned"
    case userAssigned = "user-assigned"
}

typealias CountryData = [CountryDatum]
