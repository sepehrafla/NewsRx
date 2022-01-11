//
//  ArticleTableViewCell.swift
//  NewsRx
//
//  Created by Sepehr Aflatounian on 2022-01-10.
//

import Foundation
import UIKit

class ArticleTableViewCell : UITableViewCell {
    static let Identifier = "ArticleTableViewCell"
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()

    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupview () {
        addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(safeAreaLayoutGuide).offset(5)
            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
            make.height.lessThanOrEqualTo(60)
            make.width.lessThanOrEqualTo(90)
        }
        addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 3
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.snp.makeConstraints{make in
            make.top.equalTo(titleLabel).offset(5)
            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
        }
    }
}
