//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 18.10.2022.
//

import Foundation

protocol ViewToPresenterHomePageProtocol {
    var homePageInteractor: PresenterToInteractorHomePageProtocol? {get set}
    var homePageView: PresenterToViewHomePageProtocol? {get set}
    func takeFood()
}

protocol PresenterToInteractorHomePageProtocol {
    var homePagePresenter: InteractorToPresenterHomePageProtocol? {get set}
    func takeAllTheFood()
}

protocol InteractorToPresenterHomePageProtocol {
    func sendDataToPresenter(foodsList: [Foods])
}

protocol PresenterToViewHomePageProtocol {
    func sendDataToView(foodsList: [Foods])
}

protocol PresenterToRouterHomePageProtocol {
    static func createModule(ref: HomePageViewController)
}
