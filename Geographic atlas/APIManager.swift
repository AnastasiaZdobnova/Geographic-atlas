
//
//  APIManager.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 12.05.2023.
//

import Foundation

class APIManager{
    static let shared = APIManager()
    let urlString = "https://restcountries.com/v3.1/all"
    
    func getData(){
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {return}
            if let contryData = try? JSONDecoder().decode(CountryData.self, from: data){
                print("Success decoding")
                for country in contryData {
                      let region = country.region
                      print(region)
                }
                print("уникальные регионы")
                var uniqueRegions = Set<String>()

                for country in contryData {
                    let region = country.region
                    uniqueRegions.insert(region)
                }

                for region in uniqueRegions {
                    print(region)
                }
            } else{
                print("Fail decofing")
            }
        }.resume()
    }
}
