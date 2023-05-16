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
    
    let populationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor.textAdditionalColor
        return label
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor.textAdditionalColor
        return label
    }()
    
    let currenciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor.textAdditionalColor
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
        
        navigationController?.pushViewController(countryDetailsVC, animated: true)
    }
    //MARK: -  override init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        [contentWhiteView, flagsImageView, countryNameLabel, capitalLabel,chevronUpLabel].forEach {
            contentView.addSubview($0)
        }
        
        [populationLabel, areaLabel, currenciesLabel, learnMoreButton].forEach {
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
        
        populationLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagsImageView)
            make.top.equalTo(flagsImageView.snp.bottom).offset(12)
        }
        
        areaLabel.snp.makeConstraints { make in
            make.leading.equalTo(populationLabel)
            make.top.equalTo(populationLabel.snp.bottom).offset(8)
        }
        
        currenciesLabel.snp.makeConstraints { make in
            make.leading.equalTo(populationLabel)
            make.top.equalTo(areaLabel.snp.bottom).offset(8)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.leading.equalTo(populationLabel)
            make.top.equalTo(currenciesLabel.snp.bottom).offset(12)
            make.trailing.equalTo(contentWhiteView).offset(-12)
            make.bottom.equalTo(contentWhiteView).offset(-12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

