//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 28.10.2022.
//

import Foundation

protocol ViewToPresenterDetailProtocol {
    var detailInteractor: PresenterToInteractorDetailProtocol? {get set}
    var detailView: PresenterToViewDetailProtocol? {get set}
    func addToCart(yemekAdi: String, yemekResimAdi: String, yemekFiyat: Int, yemekSiparisAdet: Int, kullaniciAdi: String)
}

protocol PresenterToInteractorDetailProtocol {
    var detailPresenter: InteractorToPresenterDetailProtocol? {get set}
    func addFoodToCart(yemekAdi: String, yemekResimAdi: String, yemekFiyat: Int, yemekSiparisAdet: Int, kullaniciAdi: String)
}

protocol InteractorToPresenterDetailProtocol {
    func presenteraVeriGonder(foodsList: [Foods])
}

protocol PresenterToViewDetailProtocol {
    func sendDataToView(foodsList: [Foods])
}

protocol PresenterToRouterDetailProtocol {
    static func createModule(ref: DetailViewController)
}
