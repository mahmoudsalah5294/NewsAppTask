//
//  NetworkDataSource.swift
//  NewsAppTask
//
//  Created by Mahmoud Mohamed on 24/12/2021.
//

import Foundation

protocol NetworkDataSourceProtocol{
    
    func fetchAllNews(completion: @escaping ResponseHandler<NewsModel>)
}


class NetworkDataSource:NetworkDataSourceProtocol{
    private let storageManager = StorageManager()
    func fetchAllNews(completion: @escaping ResponseHandler<NewsModel>){
        let url = Endpoints.baseURL+Endpoints.country+storageManager.getCountry()+Endpoints.category+storageManager.getCategory()+Endpoints.key
        
        print("url: \(url)")
        RequestHandler.shared.get(url: url, completion: completion)
    }
}
