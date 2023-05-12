
//
//  APIManager.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 12.05.2023.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    let urlString = "https://restcountries.com/v3.1/all"
    var completionHandler: (() -> Void)?
    
    var countryData: [CountryDatum] = [] // Добавленное свойство для хранения данных стран
    
    func getData() {
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if let countryData = try? JSONDecoder().decode([CountryDatum].self, from: data) {
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
}

