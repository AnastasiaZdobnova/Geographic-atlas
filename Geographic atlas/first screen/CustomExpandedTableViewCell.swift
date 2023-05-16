//
//  CustomExpandedTableViewCell.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 14.05.2023.
//


import Foundation
import UIKit

class CustomExpandedTableViewCell: UITableViewCell {
    
    
    weak var navigationController: UINavigationController?
    
    let flagsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    let contentWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    var countryNameLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont(name: "SFProText-Bold", size: 17)
        lable.textColor = .black
        return lable
    }()
    
    let chevronUpLabel : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.up")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let capitalLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont(name: "SFProText-Regular", size: 13)
        lable.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1.0)
        return lable
    }()
    
    let populationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1.0)
        return label
    }()

    let areaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1.0)
        return label
    }()

    let currenciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1.0)
        return label
    }()
    
    let learnMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Learn more", for: .normal)
        button.addTarget(self, action: #selector(learnMoreButtonTapped), for: .touchUpInside)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flagsImageView.image = nil
        countryNameLabel.text = ""
        capitalLabel.text = ""
        populationLabel.text = ""
        areaLabel.text = ""
        currenciesLabel.text = ""
        
    }
    
    @objc func learnMoreButtonTapped() {
        // Создать экземпляр CountryDetailsViewController и передать необходимые данные
        let countryDetailsVC = CountryDetailsViewController()
        // Настройте CountryDetailsViewController с использованием переданных данных
        countryDetailsVC.title = countryNameLabel.text

        if let countryData = APIManager.shared.countryData.first(where: { $0.name.common == countryNameLabel.text }) {
            // Вытащите нужные данные из countryData
            countryDetailsVC.flagsImageView.image = UIImage(data: try! Data(contentsOf: URL(string: countryData.flags.png)!))
            
            countryDetailsVC.regionNameLabel.text = countryData.region
            countryDetailsVC.capitalNameLabel.text = countryData.capital?.first
            if let latlng = countryData.capitalInfo.latlng {
                let latitude = latlng[0]
                let longitude = latlng[1]
                
                let coordinatesString = String(latitude) + ", " + String(longitude)
                countryDetailsVC.coordinatesNameLabel.text = coordinatesString
            } else {
                countryDetailsVC.coordinatesNameLabel.text = "Нет данных о координатах"
            }
            
            countryDetailsVC.populationNameLabel.text = String(countryData.population)
            countryDetailsVC.areaNameLabel.text = String(countryData.area)
            let timezonesString = countryData.timezones.joined(separator: "\n")
            countryDetailsVC.timezonesNameLabel.text = timezonesString
            
        }
        
        // Перейти на новый экран
        // Можете использовать UINavigationController, чтобы добавить кнопку возврата на предыдущий экран
        navigationController?.pushViewController(countryDetailsVC, animated: true)
    }
    

   

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        [contentWhiteView, flagsImageView, countryNameLabel, capitalLabel,chevronUpLabel].forEach {
            contentView.addSubview($0)
        }
        
        [populationLabel, areaLabel, currenciesLabel, learnMoreButton].forEach {
            contentView.addSubview($0)
        }
        
        
        NSLayoutConstraint.activate([
            contentWhiteView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            contentWhiteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentWhiteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentWhiteView.heightAnchor.constraint(equalToConstant: 216),
            
            flagsImageView.topAnchor.constraint(equalTo: contentWhiteView.topAnchor, constant: 16),
            flagsImageView.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor, constant: 16),
            flagsImageView.heightAnchor.constraint(equalToConstant: 48),
            flagsImageView.widthAnchor.constraint(equalToConstant: 82),
            
            countryNameLabel.topAnchor.constraint(equalTo: flagsImageView.topAnchor),
            countryNameLabel.leadingAnchor.constraint(equalTo: flagsImageView.trailingAnchor, constant: 16),
            
            capitalLabel.leadingAnchor.constraint(equalTo: countryNameLabel.leadingAnchor),
            capitalLabel.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 4),
            
            chevronUpLabel.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor, constant: -12),
            chevronUpLabel.topAnchor.constraint(equalTo: contentWhiteView.topAnchor, constant: 24),
//            chevronDownLabel.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor, constant: -24)
            
            populationLabel.leadingAnchor.constraint(equalTo: flagsImageView.leadingAnchor),
            populationLabel.topAnchor.constraint(equalTo: flagsImageView.bottomAnchor, constant: 12),
            
            areaLabel.leadingAnchor.constraint(equalTo: populationLabel.leadingAnchor),
            areaLabel.topAnchor.constraint(equalTo: populationLabel.bottomAnchor, constant: 8),
            
            currenciesLabel.leadingAnchor.constraint(equalTo: populationLabel.leadingAnchor),
            currenciesLabel.topAnchor.constraint(equalTo: areaLabel.bottomAnchor, constant: 8),
            
            learnMoreButton.leadingAnchor.constraint(equalTo: populationLabel.leadingAnchor),
            learnMoreButton.topAnchor.constraint(equalTo: currenciesLabel.bottomAnchor, constant: 12),
            learnMoreButton.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor, constant: -12),
            learnMoreButton.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor, constant: -12)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

