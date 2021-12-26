//
//  OnBoardingViewController.swift
//  NewsAppTask
//
//  Created by Mahmoud Mohamed on 26/12/2021.
//

import UIKit
import OrderedCollections

class OnBoardingViewController: UIViewController {
    
    private let countries:OrderedDictionary = ["Select Country":"Select Country","Argentina":"ar","australia":"au","austria":"at","belgium":"be","brazil":"br","bulgaria":"bg","canada":"ca","china":"cn","colombia":"co","cuba":"cu","czech republic":"cz","egypt":"eg","france":"fr","germany":"de","greece":"gr","hong kong":"hk","hungary":"hu","india":"in","indonesia":"id","ireland":"ie","italy":"it","japan":"jp","latvia":"lv","lithuania":"lt","malaysia":"my","mexico":"mx","morocco":"ma","netherlands":"nl","new zealand":"nz","nigeria":"ng","norway":"no","philippines":"ph","poland":"pl","portugal":"pt","romania":"ro","russia":"ru","saudi arabia":"sa","serbia":"rs","singapore":"sg","slovakia":"sk","slovenia":"si","south africa":"za","south korea":"kr","sweden":"se","switzerland":"ch","taiwan":"tw","thailand":"th","turkey":"tr","uae":"ae","ukraine":"ua","united kingdom":"gb","united states":"us","venuzuela":"ve"]
    private let category:[String] = ["Select Category","business","entertainment","general","health","science","sports","technology"]
    
    @IBOutlet weak var doneBtn: UIButton!
    
    private let storageManager = StorageManager()
    private let navigationManager = NavigationManager()
    
    private var status = (false,false)
    private var selectedCountry:String?{
        didSet{
            if selectedCountry != nil && selectedCountry != "Select Country"{
                status.0 = true
            }else{
                status.0 = false
            }
            enableDisable(btn: doneBtn, tup: &status)
            
        }
    }
    private var selectedCategory:String?{
        didSet{
            if selectedCategory != nil && selectedCategory != "Select Category"{
                status.1 = true
            }else{
                status.1 = false
            }
            enableDisable(btn: doneBtn, tup: &status)
        }
    }

    @IBOutlet private weak var countryPicker: UIPickerView!
    
    @IBOutlet private weak var categoryPicker: UIPickerView!
    
    
    
    @IBAction func setSettings(_ sender: UIButton) {
        setData(country: selectedCountry ?? "eg", category: selectedCategory ?? "")
        updateFlag()
        navigationManager.show(screen: .homePage, inController: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countryPicker.delegate = self
        countryPicker.dataSource = self
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        countryPicker.tag = 1
        categoryPicker.tag = 2
        
    }
    
}


extension OnBoardingViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag{
        case 1:
            return countries.count
        case 2:
            return category.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)->String{
        switch pickerView.tag{
        case 1:
            return Array(countries.keys)[row]
        case 2:
            return category[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag{
        case 1:
            self.selectedCountry = Array(countries.values)[row]
        case 2:
            self.selectedCategory = category[row]
        default:
            print("wrong Tag")
        }
        
        
        
}
}

extension OnBoardingViewController{
    func enableDisable(btn:UIButton,tup: inout(Bool,Bool)){
        if tup.0 == true && tup.1 == true{
            btn.isEnabled = true
        }else{
            btn.isEnabled = false
        }
    }
    
    func updateFlag(){
        storageManager.setOnBoarding()
    }
    
    func setData(country:String,category:String){
        storageManager.setCountry(country: country)
        storageManager.setCategory(category: category)
    }
}


