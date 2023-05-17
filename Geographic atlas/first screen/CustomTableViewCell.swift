//
//  CustomTableViewCell.swift
//  Geographic atlas
//
//  Created by Анастасия Здобнова on 14.05.2023.
//

import Foundation
import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    var isCellOpen: Bool = false
    
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
    
    let chevronDownLabel : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flagsImageView.image = nil
        countryNameLabel.text = ""
        capitalLabel.text = ""
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        [contentWhiteView, flagsImageView, countryNameLabel, capitalLabel,chevronDownLabel].forEach {
            contentView.addSubview($0)
        }
        
        
        contentWhiteView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(12)
            make.leading.equalTo(contentView).offset(16)
            make.bottom.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(72)
        }
        
        flagsImageView.snp.makeConstraints { make in
            make.top.equalTo(contentWhiteView).offset(16)
            make.leading.equalTo(contentWhiteView).offset(16)
            make.bottom.equalTo(contentWhiteView).offset(-16)
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
        
        chevronDownLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentWhiteView).offset(-12)
            make.top.equalTo(contentWhiteView).offset(24)
            make.bottom.equalTo(contentWhiteView).offset(-24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}

