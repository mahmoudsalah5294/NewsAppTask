//
//  NavigationManager.swift
//  NewsAppTask
//
//  Created by Mahmoud Mohamed on 26/12/2021.
//

import UIKit


class NavigationManager{
    
    enum Screen {
        case onBoarding
        case homePage
    }
    
    func show(screen:Screen,inController:UIViewController) {
        var viewController: UIViewController!
        switch screen{
        case .homePage:
            viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RootNavigationController")
        case .onBoarding:
            viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "OnBoardingViewController")
        }
        
        if let sceneDelegate = inController.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window{
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
        }
    }
}
