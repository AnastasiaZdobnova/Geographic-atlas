//
//  ViewController.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 12.05.2023.
//
//Какие у меня есть секции  "Europe" "Asia" "Africa" "Oceania" "Americas" "Antarctic"
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "World countries"
        
        APIManager.shared.completionHandler = { [weak self] in
            self?.printUnique()
        }
        
        APIManager.shared.getData()
        
        var tableView = UITableView(frame: view.bounds, style: .plain)
        // Добавление UITableView в иерархию представлений
        view.addSubview(tableView)
        
        // Настройка делегата и источника данных
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func printUnique() {
        if DataManager.uniqueRegions.isEmpty {
            print("Массив uniqueRegions пуст")
        } else {
            for region in DataManager.uniqueRegions {
                print(region)
            }
        }
    }
}



//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate{
    
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
            print("Вот сколько у меня секций\(DataManager.uniqueRegions.count)")
            return DataManager.uniqueRegions.count
            
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "Hello"
        return cell
    }
    
    
}

