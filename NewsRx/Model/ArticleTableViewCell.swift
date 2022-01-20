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
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 3
        return label
    }()
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
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(safeAreaLayoutGuide).offset(5)
            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(5)
        }
        addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 5
        descriptionLabel.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(5)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(5)
            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
        }
    }
}
