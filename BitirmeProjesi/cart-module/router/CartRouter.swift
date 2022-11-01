//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 29.10.2022.
//

import Foundation

class CartRouter: PresenterToRouterCartProtocol {
    static func createModule(ref: CartViewController) {
        
        let presenter = CartPresenter()
        
        ref.cartPresenterObject = presenter
        
        ref.cartPresenterObject?.cartView = ref
        ref.cartPresenterObject?.cartInteractor = CartInteractor()
        
        ref.cartPresenterObject?.cartInteractor?.cartPresenter = presenter
    }
}
