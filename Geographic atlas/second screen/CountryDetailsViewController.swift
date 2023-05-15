//
//  CountryDetailsViewController.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 15.05.2023.
//

import UIKit
import SnapKit

class CountryDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
        view.backgroundColor = backgroundColor
        self.navigationController?.navigationBar.backgroundColor = backgroundColor
    
       
        
        layout()
        // Do any additional setup after loading the view.
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1.0)
        view.backgroundColor = .yellow
        return view
    }()
    
    var flagsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        
        
        return imageView
    }()
    
    var regionDot: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        return view
    }()
    
    var regionLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 15)
        lable.textColor = .gray
        lable.text = "Region:"
        return lable
    }()
    
    
    var regionNameLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 30)
        lable.textColor = .black
        return lable
    }()
    
    var capitalDot: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        return view
    }()
    
    let capitalLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 15)
        lable.textColor = .gray
        lable.text = "Capital:"
        return lable
    }()
    
    let capitalNameLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 30)
        lable.textColor = .black
        return lable
    }()
    
    
    var coordinatesDot: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        return view
    }()
    
    let coordinatesLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 15)
        lable.textColor = .gray
        lable.text = "Сoordinates:"
        return lable
    }()
    
    let coordinatesNameLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 30)
        lable.textColor = .black
        return lable
    }()
    
    var populationDot: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        return view
    }()
    
    let populationLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 15)
        lable.textColor = .gray
        lable.text = "Population:"
        return lable
    }()
    
    let populationNameLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 30)
        lable.textColor = .black
        return lable
    }()
    
    var areaDot: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        return view
    }()
    
    let areaLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 15)
        lable.textColor = .gray
        lable.text = "Area:"
        return lable
    }()
    
    let areaNameLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 30)
        lable.textColor = .black
        return lable
    }()
    
    var currencyDot: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        return view
    }()
    
    let currencyLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 15)
        lable.textColor = .gray
        lable.text = "Currency:"
        return lable
    }()
    
    let currencyNameLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 30)
        lable.textColor = .black
        lable.text = "Пока не сделала валюту"
        return lable
    }()
    
    var timezonesDot: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        return view
    }()
    
    let timezonesLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 15)
        lable.textColor = .gray
        lable.text = "Timezones:"
        return lable
    }()
    
    let timezonesNameLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProText-Bold", size: 30)
        lable.textColor = .black
        lable.numberOfLines = 0
        return lable
    }()
    
    
//MARK: - layout()
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(flagsImageView)
        
        contentView.addSubview(regionDot)
        contentView.addSubview(regionLabel)
        contentView.addSubview(regionNameLabel)
        
        contentView.addSubview(capitalDot)
        contentView.addSubview(capitalLabel)
        contentView.addSubview(capitalNameLabel)
        
        contentView.addSubview(coordinatesDot)
        contentView.addSubview(coordinatesLabel)
        contentView.addSubview(coordinatesNameLabel)
        
        contentView.addSubview(populationDot)
        contentView.addSubview(populationLabel)
        contentView.addSubview(populationNameLabel)
        
        contentView.addSubview(areaDot)
        contentView.addSubview(areaLabel)
        contentView.addSubview(areaNameLabel)
        
        contentView.addSubview(currencyDot)
        contentView.addSubview(currencyLabel)
        contentView.addSubview(currencyNameLabel)
        
        contentView.addSubview(timezonesDot)
        contentView.addSubview(timezonesLabel)
        contentView.addSubview(timezonesNameLabel)
        
        
        scrollView.snp.makeConstraints { make in
           //make.edges.equalTo(view.safeAreaLayoutGuide)
            //make.edges.equalTo(self.view)
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
//            make.edges.width.equalTo(scrollView)
//            make.height.greaterThanOrEqualTo(view.snp.height).offset(20)
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
            //make.height.greaterThanOrEqualTo(view.snp.height).offset(20)
           
        }
        
        flagsImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(24)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(flagsImageView.snp.width).multipliedBy(193.0/343.0)
        }
        
        regionDot.snp.makeConstraints { make in
            make.top.equalTo(flagsImageView.snp.bottom).offset(32)
            make.leading.equalTo(flagsImageView).offset(8)
            make.width.height.equalTo(8)
           // make.bottom.equalTo(contentView).offset(-100)
        }
        
        regionLabel.snp.makeConstraints { make in
            make.top.equalTo(flagsImageView.snp.bottom).offset(24)
            make.leading.equalTo(regionDot.snp.trailing).offset(16)
        }
        
        regionNameLabel.snp.makeConstraints { make in
            make.top.equalTo(regionLabel.snp.bottom).offset(4)
            make.leading.equalTo(regionLabel)
        }
        
        capitalDot.snp.makeConstraints { make in
            make.top.equalTo(regionNameLabel.snp.bottom).offset(32)
            make.leading.equalTo(regionDot)
            make.width.height.equalTo(8)
        }
        
        capitalLabel.snp.makeConstraints { make in
            make.top.equalTo(regionNameLabel.snp.bottom).offset(24)
            make.leading.equalTo(regionLabel)
        }
        
        capitalNameLabel.snp.makeConstraints { make in
            make.top.equalTo(capitalLabel.snp.bottom).offset(4)
            make.leading.equalTo(regionLabel)
        }
        
        coordinatesDot.snp.makeConstraints { make in
            make.top.equalTo(capitalNameLabel.snp.bottom).offset(32)
            make.leading.equalTo(regionDot)
            make.width.height.equalTo(8)
        }
        
        coordinatesLabel.snp.makeConstraints { make in
            make.top.equalTo(capitalNameLabel.snp.bottom).offset(24)
            make.leading.equalTo(regionLabel)
        }

        coordinatesNameLabel.snp.makeConstraints { make in
            make.top.equalTo(coordinatesLabel.snp.bottom).offset(4)
            make.leading.equalTo(regionLabel)
        }
        
        populationDot.snp.makeConstraints { make in
            make.top.equalTo(coordinatesNameLabel.snp.bottom).offset(32)
            make.leading.equalTo(regionDot)
            make.width.height.equalTo(8)
        }
        
        populationLabel.snp.makeConstraints { make in
            make.top.equalTo(coordinatesNameLabel.snp.bottom).offset(24)
            make.leading.equalTo(regionLabel)
        }

        populationNameLabel.snp.makeConstraints { make in
            make.top.equalTo(populationLabel.snp.bottom).offset(4)
            make.leading.equalTo(regionLabel)
        }
        
        areaDot.snp.makeConstraints { make in
            make.top.equalTo(populationNameLabel.snp.bottom).offset(32)
            make.leading.equalTo(regionDot)
            make.width.height.equalTo(8)
        }
        
        areaLabel.snp.makeConstraints { make in
            make.top.equalTo(populationNameLabel.snp.bottom).offset(24)
            make.leading.equalTo(regionLabel)
        }

        areaNameLabel.snp.makeConstraints { make in
            make.top.equalTo(areaLabel.snp.bottom).offset(4)
            make.leading.equalTo(regionLabel)
        }
        
        currencyDot.snp.makeConstraints { make in
            make.top.equalTo(areaNameLabel.snp.bottom).offset(32)
            make.leading.equalTo(regionDot)
            make.width.height.equalTo(8)
        }
        
        currencyLabel.snp.makeConstraints { make in
            make.top.equalTo(areaNameLabel.snp.bottom).offset(24)
            make.leading.equalTo(regionLabel)
        }

        currencyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(currencyLabel.snp.bottom).offset(4)
            make.leading.equalTo(regionLabel)
        }
        
        
        
        timezonesDot.snp.makeConstraints { make in
            make.top.equalTo(currencyNameLabel.snp.bottom).offset(32)
            make.leading.equalTo(regionDot)
            make.width.height.equalTo(8)
        }
        
        timezonesLabel.snp.makeConstraints { make in
            make.top.equalTo(currencyNameLabel.snp.bottom).offset(24)
            make.leading.equalTo(regionLabel)
        }

        timezonesNameLabel.snp.makeConstraints { make in
            make.top.equalTo(timezonesLabel.snp.bottom).offset(4)
            make.leading.equalTo(regionLabel)
           // make.bottom.equalTo(contentView.snp.bottom).offset(-40)
        }
        

        
        contentView.snp.makeConstraints { make in
                    make.bottom.equalTo(timezonesNameLabel.snp.bottom).offset(16) // Замените timezonesNameLabel на последний элемент в вашем contentView
                }
    }
    
}
