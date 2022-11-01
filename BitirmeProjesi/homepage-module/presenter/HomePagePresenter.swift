//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 18.10.2022.
//

import Foundation

class HomePagePresenter: ViewToPresenterHomePageProtocol {
    var homePageInteractor: PresenterToInteractorHomePageProtocol?
    var homePageView: PresenterToViewHomePageProtocol?
    
    func takeFood() {
        homePageInteractor?.takeAllTheFood()
    }
}

extension HomePagePresenter: InteractorToPresenterHomePageProtocol{
    func sendDataToPresenter(foodsList: [Foods]) {
        homePageView?.sendDataToView(foodsList: foodsList)
    }
}
