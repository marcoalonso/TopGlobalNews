//
//  NoticiaData.swift
//  Noticias
//
//  Created by Marco Alonso Rodriguez on 29/10/22.
//

 

import Foundation

struct NoticiaData: Codable {
    let articles: [Noticia]
}

struct Noticia : Codable {
    let source: Source
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct Source: Codable {
    let name: String?
}
 
