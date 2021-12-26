//
//  NetworkDataSource.swift
//  NewsAppTask
//
//  Created by Mahmoud Mohamed on 24/12/2021.
//

import Foundation

protocol NetworkDataSourceProtocol{
    
    func fetchNews(searchWord:String,completion: @escaping ResponseHandler<NewsModel>)
    
}


class NetworkDataSource:NetworkDataSourceProtocol{
  
    private let storageManager = StorageManager()
    func fetchNews(searchWord:String,completion: @escaping ResponseHandler<NewsModel>){
        let url = Endpoints.baseURL+Endpoints.searchWord+searchWord+Endpoints.country+storageManager.getCountry()+Endpoints.category+storageManager.getCategory()+Endpoints.sortBy+Endpoints.key
        
        print("url: \(url)")
        RequestHandler.shared.get(url: url, completion: completion)
    }
}
