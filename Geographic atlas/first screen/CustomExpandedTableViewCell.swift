//
//  CustomExpandedTableViewCell.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 14.05.2023.
//


import Foundation
import UIKit
import SnapKit

class CustomExpandedTableViewCell: UITableViewCell {
    
    weak var navigationController: UINavigationController?
    
    let flagsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let contentWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cellColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    var countryNameLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 17)
        lable.textColor = UIColor.textAccentColor
        return lable
    }()
    
    let chevronUpLabel : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.up")
        imageView.tintColor = UIColor.arrowColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let capitalLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Regular", size: 13)
        lable.textColor = UIColor.textAdditionalColor
        return lable
    }()
    
    let populationLabelBeginning: UILabel = {
        let label = UILabel()
        label.text = "Population:"
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor.textAdditionalColor
        return label
    }()
    
    let populationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor.textAccentColor
        return label
    }()
    
    let areaLabelBeginning: UILabel = {
        let label = UILabel()
        label.text = "Area:"
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor.textAdditionalColor
        return label
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor.textAccentColor
        return label
    }()
    
    let currenciesLabelBeginning: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor.textAdditionalColor
        label.text = "Currencies: "
        return label
    }()
    
    let currenciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor.textAccentColor
        return label
    }()
    
    
    
    let learnMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Learn more", for: .normal)
        button.addTarget(self, action: #selector(learnMoreButtonTapped), for: .touchUpInside)
        button.setTitleColor(UIColor.learnMoreButtonColor, for: .normal)
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
    //MARK: -  learnMoreButtonTapped()
    @objc func learnMoreButtonTapped() {
        // Создать экземпляр CountryDetailsViewController и передать необходимые данные
        let countryDetailsVC = CountryDetailsViewController()
        // Настройте CountryDetailsViewController с использованием переданных данных
        countryDetailsVC.title = countryNameLabel.text
        
        if let countryData = APIManager.shared.countryData.first(where: { $0.name.common == countryNameLabel.text }) {
            
            countryDetailsVC.flagsImageView.image = UIImage(data: try! Data(contentsOf: URL(string: countryData.flags.png)!))
            countryDetailsVC.regionNameLabel.text = countryData.region
            
            if let capital = countryData.capital?.first {
                countryDetailsVC.capitalNameLabel.text = capital
            } else {
                countryDetailsVC.capitalNameLabel.text = "No capital"
            }
            
            if let latlng = countryData.capitalInfo.latlng {
                let latitude = latlng[0]
                let longitude = latlng[1]
                
                var latitudeDegrees = ""
                var latitudeMinutes = ""
                var longitudeDegrees = ""
                var longitudeMinutes = ""
                
                var numberString = String(latitude)
                var parts = numberString.split(separator: ".")

                if parts.count == 2 {
                    latitudeDegrees = String(parts[0])
                    latitudeMinutes = String(parts[1])
                }
                
                numberString = String(longitude)
                parts = numberString.split(separator: ".")

                if parts.count == 2 {
                    longitudeDegrees = String(parts[0])
                    longitudeMinutes = String(parts[1])
                }
                
                let coordinatesString = latitudeDegrees + "\u{00B0}" + latitudeMinutes + "\u{2032}, " + longitudeDegrees + "\u{00B0}" + longitudeMinutes + "\u{2032}"
                countryDetailsVC.coordinatesNameLabel.text = coordinatesString
            } else {
                countryDetailsVC.coordinatesNameLabel.text = "No data about coordinates"
            }
            
            if (countryData.population / 1000000) != 0{
                countryDetailsVC.populationNameLabel.text = String(countryData.population / 1000000) + " mln"
            }
            else if (countryData.population / 1000) != 0 {
                countryDetailsVC.populationNameLabel.text = String(countryData.population / 1000) + " ths"
            }
            else {
                countryDetailsVC.populationNameLabel.text = String(countryData.population) + " people"
            }
            
            let area: Double = countryData.area

            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.groupingSeparator = " "

            let formattedArea = numberFormatter.string(from: NSNumber(value: area))

            if let formattedArea = formattedArea {
                countryDetailsVC.areaNameLabel.text = formattedArea + " km²"
            }
            
           
            
            let timezonesString = countryData.timezones.joined(separator: "\n")
            countryDetailsVC.timezonesNameLabel.text = timezonesString
            
        }
        
        navigationController?.pushViewController(countryDetailsVC, animated: true)
    }
    //MARK: -  override init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        [contentWhiteView, flagsImageView, countryNameLabel, capitalLabel,chevronUpLabel].forEach {
            contentView.addSubview($0)
        }
        
        [populationLabelBeginning, populationLabel,areaLabelBeginning, areaLabel, currenciesLabelBeginning, currenciesLabel, learnMoreButton].forEach {
            contentView.addSubview($0)
        }
        
        contentWhiteView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(12)
            make.leading.equalTo(contentView).offset(16)
            make.bottom.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(216)
        }
        
        flagsImageView.snp.makeConstraints { make in
            make.top.equalTo(contentWhiteView).offset(16)
            make.leading.equalTo(contentWhiteView).offset(16)
            make.height.equalTo(48)
            make.width.equalTo(82)
        }
        
        countryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(flagsImageView)
            make.leading.equalTo(flagsImageView.snp.trailing).offset(16)
        }
        
        capitalLabel.snp.makeConstraints { make in
            make.leading.equalTo(countryNameLabel)
            make.top.equalTo(countryNameLabel.snp.bottom).offset(4)
        }
        
        chevronUpLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentWhiteView).offset(-12)
            make.top.equalTo(contentWhiteView).offset(24)
        }
        
        populationLabelBeginning.snp.makeConstraints { make in
            make.leading.equalTo(flagsImageView)
            make.top.equalTo(flagsImageView.snp.bottom).offset(12)
        }

        populationLabel.snp.makeConstraints { make in
            make.leading.equalTo(populationLabelBeginning.snp.trailing).offset(4)
            make.top.equalTo(populationLabelBeginning)
            make.bottom.equalTo(populationLabelBeginning)
        }
        
        areaLabelBeginning.snp.makeConstraints { make in
            make.leading.equalTo(populationLabelBeginning)
            make.top.equalTo(populationLabelBeginning.snp.bottom).offset(8)
        }
        
        areaLabel.snp.makeConstraints { make in
            make.leading.equalTo(areaLabelBeginning.snp.trailing).offset(4)
            make.top.equalTo(areaLabelBeginning)
            make.bottom.equalTo(areaLabelBeginning)
        }
        
        currenciesLabelBeginning.snp.makeConstraints { make in
            make.leading.equalTo(areaLabelBeginning)
            make.top.equalTo(areaLabel.snp.bottom).offset(8)
        }

        currenciesLabel.snp.makeConstraints { make in
            make.leading.equalTo(currenciesLabelBeginning.snp.trailing).offset(4)
            make.top.equalTo(currenciesLabelBeginning.snp.top)
            make.bottom.equalTo(currenciesLabelBeginning)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(currenciesLabel.snp.bottom).offset(26)
            make.centerX.equalTo(contentWhiteView)
            make.bottom.equalTo(contentWhiteView).offset(-26)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

