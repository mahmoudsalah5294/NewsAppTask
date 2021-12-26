//
//  ViewController.swift
//  NewsAppTask
//
//  Created by Mahmoud Mohamed on 24/12/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet private weak var mySearchBar: UISearchBar!
    
    @IBOutlet private weak var homeTableView: UITableView!
    
    
    var datasource:NetworkDataSourceProtocol?
    var homeViewModel:HomeViewModelProtocol?
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        homeTableView.rowHeight = 250
        mySearchBar.delegate = self
        datasource = NetworkDataSource()
        homeViewModel = HomeViewModel(dataSource: datasource!)
        
        
//        homeViewModel?.dataDriver.drive(onNext: { newsArticles in
//            self.articlesArray = newsArticles
//        })

       
        
        homeViewModel?.dataDriver.drive(homeTableView.rx.items(cellIdentifier: "Cell")){ row , item , cell in
            (cell as? MyCustomCell)?.image = item.urlToImage
            (cell as? MyCustomCell)?.title = item.title
        }
        homeViewModel?.fetchData()
       
        

    
        
        

    }
    


}


extension ViewController:UISearchBarDelegate{

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search: \(searchBar.text ?? "")")
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.mySearchBar.endEditing(true)
        print("cancel")
    }
    
}

extension ViewController{
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        homeTableView.rx.modelSelected(Article.self).subscribe { article in
            let detailsVC = segue.destination as? DetailsViewController
            
            print("\(article.element?.title)")
            detailsVC?.newsModel = article.element
            
        }
    }
    
}
