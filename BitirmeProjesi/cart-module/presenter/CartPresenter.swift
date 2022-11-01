//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 29.10.2022.
//

import Foundation

class CartPresenter: ViewToPresenterCartProtocol {
    var cartInteractor: PresenterToInteractorCartProtocol?
    var cartView: PresenterToViewCartProtocol?
    
    func cartTakeFood(userName: String) {
        cartInteractor?.cartTakeAllTheFood(userName: userName)
    }
    
    func cartFoodDelete(id: Int, userName: String) {
        cartInteractor?.cartDeleteAllFood(id: id, userName: userName)
    }
}
extension CartPresenter: InteractorToPresenterCartProtocol{
    func sendDataToPresenter(foodsList: [CartFoods]) {
        cartView?.sendDataToView(foodList: foodsList)
    }
}
