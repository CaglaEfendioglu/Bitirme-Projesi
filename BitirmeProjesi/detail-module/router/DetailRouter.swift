//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 28.10.2022.
//

import Foundation

class DetailRouter: PresenterToRouterDetailProtocol {
    static func createModule(ref: DetailViewController) {
        
        let presenter = DetailPresenter()
        
        ref.detailPresenterObject = presenter
        
        ref.detailPresenterObject?.detailView = ref
        ref.detailPresenterObject?.detailInteractor = DetailInteractor()
        
        ref.detailPresenterObject?.detailInteractor?.detailPresenter = presenter
    }
}
