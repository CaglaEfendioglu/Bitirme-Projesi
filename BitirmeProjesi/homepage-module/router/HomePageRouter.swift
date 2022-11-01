//
//  File.swift
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 18.10.2022.
//

import Foundation

class HomePageRouter: PresenterToRouterHomePageProtocol {
    static func createModule(ref: HomePageViewController) {
        
        let presenter = HomePagePresenter()
        
        ref.homePagePresenterObject = presenter
        
        ref.homePagePresenterObject?.homePageView = ref
        ref.homePagePresenterObject?.homePageInteractor = HomePageInteractor()
        
        ref.homePagePresenterObject?.homePageInteractor?.homePagePresenter = presenter
    }
}
