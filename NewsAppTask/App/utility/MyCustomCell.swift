//
//  MyCustomCell.swift
//  NewsAppTask
//
//  Created by Mahmoud Mohamed on 24/12/2021.
//

import UIKit
import Kingfisher

class MyCustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    @IBOutlet private weak var newsImage: UIImageView!
    
    @IBOutlet private weak var newsTitle: UILabel!
    
    var title:String?{
        didSet{
            newsTitle.text = title
        }
    }
    
    var image:String?{
        didSet{
            let indicator = loadingIndicator()
            
            let url = URL(string: image ?? "")
            newsImage.kf.setImage(with: url,placeholder: UIImage(named: "no_image")) { (url) in
                indicator.stopAnimating()
            }
        }
    }
    
    func loadingIndicator()->UIActivityIndicatorView{
        let imageLoadingIndicator = UIActivityIndicatorView(style: .large)
        imageLoadingIndicator.center = newsImage.center
        imageLoadingIndicator.startAnimating()
        newsImage?.addSubview(imageLoadingIndicator)
        
        return imageLoadingIndicator
    }
    
}
