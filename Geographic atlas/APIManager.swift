
//
//  APIManager.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 12.05.2023.
//

import Foundation
import UIKit

class APIManager {
    
    static let shared = APIManager()
    //let urlString = "https://restcountries.com/v3.1/all"
    let urlString = "https://restcountries.com/v3.1/all?fields=name,cca2,currencies,capital,region,area,flag,population,flags"
    var completionHandler: (() -> Void)?
    
    //var countryData: [CountryDatum] = [] // Добавленное свойство для хранения данных стран
    var countryData: [CountryDatum2] = [] // Добавленное свойство для хранения данных стран
    var countryDataFull: [CountryDatum] = []
    
    func getData() {
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
//            if let countryData = try? JSONDecoder().decode([CountryDatum].self, from: data) {
            if let countryData = try? JSONDecoder().decode([CountryDatum2].self, from: data) {
                print("Success decoding")
                
                self.countryData = countryData // Сохраняем данные стран в свойство countryData
                
                for country in countryData {
                    let region = country.region
                    if !DataManager.uniqueRegions.contains(region) {
                        DataManager.uniqueRegions.append(region)
                    }
                }
                
                DispatchQueue.main.async {
                    self.completionHandler?()
                }
            } else {
                print("Fail decoding")
            }
        }
        
        task.resume()
    }
    
    func getDataFull(urlString: String) {
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if let countryData = try? JSONDecoder().decode([CountryDatum].self, from: data) {
                print("Success decoding")
                
                DispatchQueue.main.async {
                    self.completionHandler?()
                }
                self.countryDataFull = countryData
            } else {
                print("Fail decoding")
            }
        }
        
        task.resume()
    }
}

