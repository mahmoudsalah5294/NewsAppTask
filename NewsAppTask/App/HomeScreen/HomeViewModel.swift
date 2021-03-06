//
//  HomeViewModel.swift
//  NewsAppTask
//
//  Created by Mahmoud Mohamed on 24/12/2021.
//

import RxSwift
import RxCocoa

protocol HomeViewModelProtocol{
    func fetchData(searchName: String)
    var dataDriver:Driver<[Article]>{get}
}

class HomeViewModel:HomeViewModelProtocol{
    private var dataSubject = PublishSubject<[Article]>()
    var dataDriver: Driver<[Article]>
    private var dataSource:NetworkDataSourceProtocol
    
    
    init(dataSource:NetworkDataSourceProtocol){
        dataDriver = dataSubject.asDriver(onErrorJustReturn: [])
        self.dataSource = dataSource
    }
    func fetchData(searchName: String) {
        dataSource.fetchNews(searchWord: searchName){response in
            switch(response.status!){
            case .success:
                if let data = response.data{
                    let articles = data.articles
                    print("Data: \(articles.count)")
                    self.dataSubject.onNext(articles)
                }
            case .failure:
                if response.message != nil{
                    print("Error: \(response.message ?? "error unkonwn")")
                }
            }
        }
    }
 
}
