//
//  EndPoints.swift
//  NewsAppTask
//
//  Created by Mahmoud Mohamed on 24/12/2021.
//

import Foundation

struct Endpoints {
    
    
    static let baseURL = "https://newsapi.org/v2/top-headlines?"
        
        
    static let country = "country="
    
    static let category = "&category="
    
    static let key = "&apiKey=ab0aaca68abe4f02a6a0f0764e1c0c56"
    
    static let newsEndPoint = baseURL + country + category + key
}
