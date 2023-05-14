//
//  CustomTableViewCell.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 14.05.2023.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let flagsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    let contentWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let countryNameLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        lable.textColor = .black
        lable.numberOfLines = 2
        return lable
    }()
    
    let capitalLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        lable.textColor = .systemPink
        lable.numberOfLines = 2
        return lable
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            [contentWhiteView, flagsImageView, countryNameLabel, capitalLabel].forEach {
                contentView.addSubview($0)
            }
            
            NSLayoutConstraint.activate([
                contentWhiteView.topAnchor.constraint(equalTo: contentView.topAnchor),
                contentWhiteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                contentWhiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                contentWhiteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                flagsImageView.topAnchor.constraint(equalTo: contentWhiteView.topAnchor, constant: 16),
                flagsImageView.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor, constant: 16),
                flagsImageView.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor, constant: -16),
                
                countryNameLabel.topAnchor.constraint(equalTo: flagsImageView.topAnchor),
                countryNameLabel.leadingAnchor.constraint(equalTo: flagsImageView.leadingAnchor, constant: 16),
                
                capitalLabel.leadingAnchor.constraint(equalTo: countryNameLabel.trailingAnchor, constant: 16),
                capitalLabel.topAnchor.constraint(equalTo: countryNameLabel.topAnchor)
                
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
}

