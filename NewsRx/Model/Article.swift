//
//  Article.swift
//  NewsRx
//
//  Created by Sepehr Aflatounian on 2022-01-10.
//

import Foundation

struct ArticlesList : Decodable {
    let articles: [Article]
}

struct Article : Decodable{
    let title : String
    let description : String?
    let urlToImage : String? 
}
