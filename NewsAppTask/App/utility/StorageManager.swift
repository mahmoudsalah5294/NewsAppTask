//
//  StorageManager.swift
//  NewsAppTask
//
//  Created by Mahmoud Mohamed on 26/12/2021.
//

import Foundation

class StorageManager{
    
    enum Key: String{
        case onBoarding
        case country
        case category
    }
    
    func isOnBoarding()-> Bool {
        UserDefaults.standard.bool(forKey: Key.onBoarding.rawValue)
    }
    
    func setOnBoarding(){
        UserDefaults.standard.set(true, forKey: Key.onBoarding.rawValue)
    }
    
    func setCountry(country:String){
        UserDefaults.standard.set(country, forKey: Key.country.rawValue)
    }
    
    func setCategory(category:String){
        UserDefaults.standard.set(category, forKey: Key.category.rawValue)
    }
    
    func getCountry()->String{
        UserDefaults.standard.object(forKey: Key.country.rawValue) as! String
    }
    
    func getCategory()->String{
        UserDefaults.standard.object(forKey: Key.category.rawValue) as! String
    }
}
