//
//  AppController.swift
//  AcronymsFinder
//
//  Created by u533623 on 12/12/22.
//

import Foundation
import UIKit

class AppController{
    
    static let shared = AppController()
    
    func loadInitialRootViewController() -> UIViewController {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let acronymSearchView : AcronymSearchViewContorller = storyboard.instantiateViewController(withIdentifier: "AcronymSearchViewContorller") as! AcronymSearchViewContorller
        
        let acronymSearchViewModel = AcronymViewModel(service: AcronymSearchAPI() as AcronymSearchAPIProtocol, viewController: acronymSearchView)
        acronymSearchView.viewModelProtocol = acronymSearchViewModel as AcronymSearchViewModelProtocol
        
        return acronymSearchView
    }
}
