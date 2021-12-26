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
    
    private var timer : DispatchSourceTimer!
    private let storageManager = StorageManager()
    private var datasource:NetworkDataSourceProtocol?
    private var homeViewModel:HomeViewModelProtocol?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        homeTableView.rowHeight = 250
        mySearchBar.delegate = self
        datasource = NetworkDataSource()
        homeViewModel = HomeViewModel(dataSource: datasource!)
        
        

       
        
        homeViewModel?.dataDriver.drive(homeTableView.rx.items(cellIdentifier: "Cell")){ row , item , cell in
            (cell as? MyCustomCell)?.image = item.urlToImage
            (cell as? MyCustomCell)?.title = item.title
        }
        startTimer()
    }
}


extension ViewController:UISearchBarDelegate{

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search: \(searchBar.text ?? "")")
        homeViewModel?.filterData(searchName: searchBar.text ?? "")
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
            
            detailsVC?.newsModel = article.element
            
        }
    }
    
}




extension ViewController{
    
    
    func startTimer()
    {
        var timeUInt64 = storageManager.getTime()
        var currentTime = DispatchTime(uptimeNanoseconds: timeUInt64)

        if timer == nil {
            timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
            timer.schedule(deadline: currentTime, repeating: 30*60)
            timer.setEventHandler {
                
                let currentDateTime = DispatchTime.now()
        
                let timeUInt64 = UInt64(currentDateTime.rawValue)
                self.storageManager.setTime(time: timeUInt64)
                self.callAPI()
            }
            timer.activate()
        } else {
            timer.schedule(deadline: currentTime, repeating: 30*60)
        }
    }
            
       func callAPI(){
           homeViewModel?.fetchData()
            }
}
