//
//  LoadingViewController.swift
//  NewsAppTask
//
//  Created by Mahmoud Mohamed on 26/12/2021.
//

import UIKit

class LoadingViewController: UIViewController {

    private var isOnBoardScreen : Bool!
    
    private let navigationManager = NavigationManager()
    private let storageManager = StorageManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        isOnBoardScreen = storageManager.isOnBoarding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInitialScreen()
    }
    
    private func showInitialScreen() {
        if isOnBoardScreen{
            navigationManager.show(screen: .homePage, inController: self)
        }else{
            navigationManager.show(screen: .onBoarding, inController: self)
        }
    }

}
