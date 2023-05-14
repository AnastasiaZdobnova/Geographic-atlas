//
//  CustomExpandedTableViewCell.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 14.05.2023.
//


import Foundation
import UIKit

class CustomExpandedTableViewCell: UITableViewCell {
    
    var isCellOpen: Bool = false
    
    
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
    
    let chevronDownLabel : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.down")
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        [contentWhiteView, flagsImageView, countryNameLabel, capitalLabel,chevronDownLabel].forEach {
            contentView.addSubview($0)
        }
        
        
        NSLayoutConstraint.activate([
            contentWhiteView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            contentWhiteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentWhiteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentWhiteView.heightAnchor.constraint(equalToConstant: 150),
            
            flagsImageView.topAnchor.constraint(equalTo: contentWhiteView.topAnchor, constant: 16),
            flagsImageView.leadingAnchor.constraint(equalTo: contentWhiteView.leadingAnchor, constant: 16),
            flagsImageView.heightAnchor.constraint(equalToConstant: 48),
            flagsImageView.widthAnchor.constraint(equalToConstant: 82),
            
            countryNameLabel.topAnchor.constraint(equalTo: flagsImageView.topAnchor),
            countryNameLabel.leadingAnchor.constraint(equalTo: flagsImageView.trailingAnchor, constant: 16),
            
            capitalLabel.leadingAnchor.constraint(equalTo: countryNameLabel.leadingAnchor),
            capitalLabel.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 4),
            
            chevronDownLabel.trailingAnchor.constraint(equalTo: contentWhiteView.trailingAnchor, constant: -12),
            chevronDownLabel.topAnchor.constraint(equalTo: contentWhiteView.topAnchor, constant: 24),
//            chevronDownLabel.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor, constant: -24)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
