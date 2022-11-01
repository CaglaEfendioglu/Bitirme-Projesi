//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 29.10.2022.
//

import Foundation

protocol ViewToPresenterCartProtocol {
    var cartInteractor: PresenterToInteractorCartProtocol? {get set}
    var cartView: PresenterToViewCartProtocol? {get set}
    func cartTakeFood(userName: String)
    func cartFoodDelete(id: Int, userName: String)
}

protocol PresenterToInteractorCartProtocol {
    var cartPresenter: InteractorToPresenterCartProtocol? {get set}
    func cartTakeAllTheFood(userName: String)
    func cartDeleteAllFood(id: Int, userName: String)
}

protocol InteractorToPresenterCartProtocol {
    func sendDataToPresenter(foodsList: [CartFoods])
}

protocol PresenterToViewCartProtocol {
    func sendDataToView(foodList: [CartFoods])
}

protocol PresenterToRouterCartProtocol {
    static func createModule(ref: CartViewController)
}
