//
//  DetailsViewController.swift
//  NewsAppTask
//
//  Created by Mahmoud Mohamed on 25/12/2021.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet private weak var myScrollView: UIScrollView!
    
    @IBOutlet private weak var newsTitle: UILabel!
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var auther: UILabel!
    
    
    @IBOutlet private weak var newsSource: UILabel!
    
    @IBOutlet private weak var newsDescription: UILabel!
    
    @IBOutlet private weak var newsUrl: UILabel!
    
    var newsModel:Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(newsModel?.title) || \(newsModel.publisher)")
        myScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 500)
        
        newsTitle.text = newsModel?.title
        auther.text = newsModel?.author
        newsSource.text = newsModel?.source.name
        newsDescription.text = newsModel?.articleDescription
        newsUrl.text = newsModel?.url
        
        let url = URL(string: newsModel?.urlToImage ?? "")
        imageView.kf.setImage(with:url,placeholder: UIImage(named: "no_image"))
        
        let clickable = UITapGestureRecognizer(target: self, action: #selector(DetailsViewController.linkClicable))
        newsUrl.isUserInteractionEnabled = true
        newsUrl.addGestureRecognizer(clickable)
    }
    
    @IBAction func linkClicable(sender:UITapGestureRecognizer){
        guard let str = newsModel?.url else{return}
        
        let url = URL(string: str)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }


}
