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
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
        label.textColor = UIColor.textAccentColor
        return label
    }()
    
    let chevronUpLabel : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.up")
        imageView.tintColor = UIColor.arrowColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let capitalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.textColor = UIColor.textAdditionalColor
        return label
    }()
    
    let populationLabelBeginning: UILabel = {
        let label = UILabel()
        label.text = "Population:"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.textColor = UIColor.textAdditionalColor
        return label
    }()
    
    let populationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.textColor = UIColor.textAccentColor
        return label
    }()
    
    let areaLabelBeginning: UILabel = {
        let label = UILabel()
        label.text = "Area:"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.textColor = UIColor.textAdditionalColor
        return label
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.textColor = UIColor.textAccentColor
        return label
    }()
    
    let currenciesLabelBeginning: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.textColor = UIColor.textAdditionalColor
        label.text = "Currencies: "
        return label
    }()
    
    let currenciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.textColor = UIColor.textAccentColor
        return label
    }()
    
    
    
    let learnMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Learn more", for: .normal)
        
        button.addTarget(self, action: #selector(learnMoreButtonTapped), for: .touchUpInside)
        button.setTitleColor(UIColor.learnMoreButtonColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
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
    @objc func learnMoreButtonTapped(_ sender: UIButton) {
        
        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            // Анимированное изменение масштаба кнопки с использованием пружинной анимации
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut,
                           animations: {
                               // Устанавливаем конечный масштаб кнопки
                               sender.transform = CGAffineTransform.identity
                           },
                           completion: nil)
        
        // Создать экземпляр CountryDetailsViewController и передать необходимые данные
        let countryDetailsVC = CountryDetailsViewController()
        // Настройте CountryDetailsViewController с использованием переданных данных
        countryDetailsVC.title = countryNameLabel.text
        
        if let countryData = APIManager.shared.countryData.first(where: { $0.name.common == countryNameLabel.text }) {
            
            let cca2 = countryData.cca2
            let countryURLString = "https://restcountries.com/v3.1/alpha/\(cca2)"
            
            
            
            
            APIManager.shared.completionHandler = { [weak self] in
                let countryDataFull = APIManager.shared.countryDataFull.first
                
                if let flagsURL = URL(string: countryDataFull!.flags.png) {
                    countryDetailsVC.flagsImageView.sd_setImage(with: flagsURL, completed: nil)
                }
                
                countryDetailsVC.regionNameLabel.text = countryDataFull!.region


                if let capital = countryDataFull!.capital?.first{
                    countryDetailsVC.capitalNameLabel.text = countryData.capital.first

                } else {
                    countryDetailsVC.capitalNameLabel.text = "No capital"
                }
                if let capital = countryDataFull!.capital?.first{
                    if let latlng = countryDataFull!.capitalInfo.latlng {
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
                    }
                }
                else{
                    countryDetailsVC.coordinatesNameLabel.text = "No data about coordinates"
                }

                if (countryDataFull!.population / 1000000) != 0{
                    countryDetailsVC.populationNameLabel.text = String(countryDataFull!.population / 1000000) + " mln"
                }
                else if (countryData.population / 1000) != 0 {
                    countryDetailsVC.populationNameLabel.text = String(countryDataFull!.population / 1000) + " ths"
                }
                else {
                    countryDetailsVC.populationNameLabel.text = String(countryDataFull!.population) + " people"
                }

                let area: Double = countryDataFull!.area

                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                numberFormatter.groupingSeparator = " "

                let formattedArea = numberFormatter.string(from: NSNumber(value: area))

                if let formattedArea = formattedArea {
                    countryDetailsVC.areaNameLabel.text = formattedArea + " km²"
                }

                if let currencies = countryDataFull!.currencies {
                    // У страны есть валюты
                    let currencyStrings = currencies.map { currency -> String in
                        let currencyCode = currency.key
                        return "\(currency.value.name) (\(currency.value.symbol ?? "")) (\(currencyCode))"
                    }
                    let allCurrenciesString = currencyStrings.joined(separator: "\n")

                    let attributedString = NSMutableAttributedString(string: allCurrenciesString)
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 4 // Задание межстрочного интервала в 4 поинта
                    attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

                    countryDetailsVC.currencyNameLabel.attributedText = attributedString
                } else {
                    // У страны нет валют
                    countryDetailsVC.currencyNameLabel.text = "The country has no currency"
                }


                let timezonesString = countryDataFull!.timezones.joined(separator: "\n")
                let attributedString = NSMutableAttributedString(string: timezonesString)
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4 // Задание межстрочного интервала в 4 поинта
                attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

                countryDetailsVC.timezonesNameLabel.attributedText = attributedString
                self?.navigationController?.pushViewController(countryDetailsVC, animated: true)
                
            }
            APIManager.shared.getDataFull(urlString: countryURLString)
        }
        
//        navigationController?.pushViewController(countryDetailsVC, animated: true)
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
            make.top.equalTo(flagsImageView).offset(4)
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
            make.top.equalTo(currenciesLabel.snp.bottom).offset(12)
            make.centerX.equalTo(contentWhiteView)
            make.height.equalTo(50)
            make.leading.equalTo(contentWhiteView).offset(16)
            make.trailing.equalTo(contentWhiteView).offset(-16)
            make.bottom.equalTo(contentWhiteView).offset(-12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

