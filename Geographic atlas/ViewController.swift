//
//  ViewController.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 12.05.2023.
//
//
import UIKit

class ViewController: UIViewController {
    
    var CountryFirstInfo = [(countryName: String, cca2: String, capital: [String]?, flags: String, isExpanded: Bool)]()
    var selectedIndexes: [IndexPath] = []
    
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "World countries"
        
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        APIManager.shared.completionHandler = { [weak self] in
            self?.printUnique()
            self?.tableView.reloadData()
        }
        
        APIManager.shared.getData()
        
        
        layout()
    }
    
    func layout(){
        
        // Добавление UITableView в иерархию представлений
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // Настройка делегата и источника данных
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        tableView.register(CustomExpandedTableViewCell.self, forCellReuseIdentifier: "CustomExpandedTableViewCell")
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
        
        
        ])
        
        
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
        return 18.0 // Задайте желаемую высоту для заголовка секции
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
        if selectedIndexes.contains(indexPath) {
            // Ячейка раскрыта, возвращаем CustomExpandedTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomExpandedTableViewCell", for: indexPath) as! CustomExpandedTableViewCell
            
            let region = DataManager.uniqueRegions[indexPath.section]
            let countries = DataManager.shared.getCountriesInRegion(region)
            let country = countries[indexPath.row]
            
            cell.countryNameLabel.text = country.countryName
            cell.capitalLabel.text = country.capital?.first
            cell.flagsImageView.image = UIImage(data: try! Data(contentsOf: URL(string: country.flags)!))
            
            return cell
        } else {
            // Ячейка закрыта, возвращаем CustomTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
            
            let region = DataManager.uniqueRegions[indexPath.section]
            let countries = DataManager.shared.getCountriesInRegion(region)
            let country = countries[indexPath.row]
            
            cell.countryNameLabel.text = country.countryName
            cell.capitalLabel.text = country.capital?.first
            cell.flagsImageView.image = UIImage(data: try! Data(contentsOf: URL(string: country.flags)!))
            
            return cell
        }
        
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40.0))
    //        headerView.backgroundColor = .lightGray
    //
    //        let titleLabel = UILabel(frame: CGRect(x: 16.0, y: 0, width: tableView.bounds.width - 32.0, height: 40.0))
    //        titleLabel.textColor = .black
    //        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
    //        titleLabel.text = DataManager.uniqueRegions[section]
    //
    //        headerView.addSubview(titleLabel)
    //
    //        return headerView
    //    }
    //
    //}
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "SFProText-Bold", size: 15)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = UIColor(red: 171/255, green: 179/255, blue: 187/255, alpha: 1.0)
        titleLabel.text = DataManager.uniqueRegions[section].uppercased()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let attributedText = NSMutableAttributedString(string: DataManager.uniqueRegions[section].uppercased())
        let letterSpacing: CGFloat = 1.2
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        titleLabel.attributedText = attributedText
        
        
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Хуета")
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
