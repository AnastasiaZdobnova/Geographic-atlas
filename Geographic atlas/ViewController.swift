//
//  ViewController.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 12.05.2023.
//
//
import UIKit

class ViewController: UIViewController {
    
    var CountryFirstInfo = [(countryName: String, cca2: String, capital: [String]?, flag: String)]()
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "World countries"
        
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        APIManager.shared.completionHandler = { [weak self] in
            self?.printUnique()
            self?.tableView.reloadData()
        }
        
        APIManager.shared.getData()
        
        // Добавление UITableView в иерархию представлений
        view.addSubview(tableView)
        
        // Настройка делегата и источника данных
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    func printUnique() {
        if DataManager.uniqueRegions.isEmpty {
            print("Массив uniqueRegions пуст")
        } else {
            for region in DataManager.uniqueRegions {
                print(region)
            }
        }
        //tableView.reloadData()
        
    }
}



//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0 // Задайте желаемую высоту для заголовка секции
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Вот сколько у меня секций\(DataManager.uniqueRegions.count)")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        let region = DataManager.uniqueRegions[indexPath.section]
        
        
        
        let countries = DataManager.shared.getCountriesInRegion(region)
        
        let country = countries[indexPath.row]
        
        CountryFirstInfo.append(country) //добавляем в список стран
        
        cell.countryNameLabel.text = country.countryName
        cell.capitalLabel.text = country.capital?.first
        //cell.flagImageView.image = UIImage(named: country.flag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40.0))
        headerView.backgroundColor = .lightGray
        
        let titleLabel = UILabel(frame: CGRect(x: 16.0, y: 0, width: tableView.bounds.width - 32.0, height: 40.0))
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.text = DataManager.uniqueRegions[section]
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
}

