//
//  ViewController.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 12.05.2023.
//
//
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var selectedIndexes: [IndexPath] = [] // индексы открытых ячеек
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for family in UIFont.familyNames {
            print("Font Family: \(family)")
            for fontName in UIFont.fontNames(forFamilyName: family) {
                print("    \(fontName)")
            }
        }
        view.backgroundColor = UIColor.viewColor
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.navigationBarColor
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        title = "World countries"
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        APIManager.shared.completionHandler = { [weak self] in
            self?.tableView.reloadData()
        }
        
        APIManager.shared.getData()
        
        layout()
    }
    
    func layout(){
        
        // Добавление UITableView в иерархию представлений
        view.addSubview(tableView)
        // Настройка делегата и источника данных
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        tableView.register(CustomExpandedTableViewCell.self, forCellReuseIdentifier: "CustomExpandedTableViewCell")
        tableView.separatorStyle = .none
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}



//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0 // Высота заголовка секции
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        headerView.addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "SFProText-Bold", size: 15)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        //titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        titleLabel.textColor = UIColor.headerInSection
        titleLabel.text = DataManager.uniqueRegions[section].uppercased()
        headerView.addSubview(titleLabel)
        // Создание атрибутированной строки с межбуквенным интервалом
        let attributedString = NSMutableAttributedString(string: titleLabel.text ?? "")
        let letterSpacing: CGFloat = 1.2
        attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length))

        // Установка атрибутированной строки в качестве текста для titleLabel
        titleLabel.attributedText = attributedString
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerView).offset(16)
            make.top.equalTo(headerView)
            make.bottom.equalTo(headerView)
            make.trailing.equalTo(headerView).offset(-16)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = selectedIndexes.firstIndex(of: indexPath) {
            // Ячейка уже выбрана, снимаем выбор
            selectedIndexes.remove(at: index)
        } else {
            // Выбрана новая ячейка, добавляем индекс в массив
            selectedIndexes.append(indexPath)
        }
        tableView.reloadData()
    }
    
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataManager.uniqueRegions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let region = DataManager.uniqueRegions[section]
        print("Вот такой у меня region - \(region)")
        let countries = DataManager.shared.getCountriesInRegion(region)
        print("Вот столько у меня должно быть ячеек - \(countries.count)")
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedIndexes.contains(indexPath) {
            // Ячейка раскрыта, возвращаем CustomExpandedTableViewCell
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomExpandedTableViewCell", for: indexPath) as! CustomExpandedTableViewCell
            
            cell.navigationController = navigationController
            
            let region = DataManager.uniqueRegions[indexPath.section]
            let countries = DataManager.shared.getCountriesInRegion(region)
            let country = countries[indexPath.row]
            
            cell.countryNameLabel.text = country.countryName
            if let capital = country.capital {
                cell.capitalLabel.text = country.capital?.first
            } else {
                cell.capitalLabel.text = "No capital"
            }
            
            cell.flagsImageView.image = UIImage(data: try! Data(contentsOf: URL(string: country.flags)!))
            
            if let countryData = APIManager.shared.countryData.first(where: { $0.cca2 == country.cca2 }) {
                
                let number: Double = countryData.area / 1000000
                let roundedResult = round(number * 1000) / 1000
                
                if (roundedResult) != 0.000 {
                    cell.areaLabel.text = String(format: "%.3f mln km\u{00B2}", roundedResult)
                }
                else{
                    cell.areaLabel.text = String(format: "%.3f km\u{00B2}", countryData.area)
                }
                
                
                if (countryData.population / 1000000) != 0{
                    cell.populationLabel.text = String(countryData.population / 1000000) + " mln"
                }
                else if (countryData.population / 1000) != 0 {
                    cell.populationLabel.text = String(countryData.population / 1000) + " ths"
                }
                else {
                    cell.populationLabel.text = String(countryData.population) + " people"
                }
            
                if let currencies = countryData.currencies {
                    // У страны есть валюты
                    
                    if currencies.count > 1 {
                        let currencyCodes = currencies.keys.sorted()
                        let joinedCurrencyCodes = currencyCodes.joined(separator: ", ")
                        cell.currenciesLabel.text = joinedCurrencyCodes
                        
                    } else if let (currencyCode, currency) = currencies.first {
                        let currencyString = "\(currency.name) (\(currency.symbol ?? "")) (\(currencyCode))"
                                print(currencyString)
                        cell.currenciesLabel.text = currencyString
                    }
                } else {
                    // У страны нет валют
                    cell.currenciesLabel.text = "The country has no currency"
                }
            }
            return cell
            
        } else {
            // Ячейка закрыта, возвращаем CustomTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
            
            let region = DataManager.uniqueRegions[indexPath.section]
            let countries = DataManager.shared.getCountriesInRegion(region)
            let country = countries[indexPath.row]
            
            cell.countryNameLabel.text = country.countryName
            if let capital = country.capital {
                cell.capitalLabel.text = country.capital?.first
            } else {
                cell.capitalLabel.text = "No capital"
            }
            cell.flagsImageView.image = UIImage(data: try! Data(contentsOf: URL(string: country.flags)!))
            
            return cell
        }
        
    }
}
