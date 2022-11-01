//
//  DetayPresenter.swift
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 28.10.2022.
//

import Foundation

class DetailPresenter: ViewToPresenterDetailProtocol {
    var detailInteractor: PresenterToInteractorDetailProtocol?
    var detailView: PresenterToViewDetailProtocol?
    
    func addToCart(yemekAdi: String, yemekResimAdi: String, yemekFiyat: Int, yemekSiparisAdet: Int, kullaniciAdi: String) {
        detailInteractor?.addFoodToCart(yemekAdi: yemekAdi, yemekResimAdi: yemekResimAdi, yemekFiyat: yemekFiyat, yemekSiparisAdet: yemekSiparisAdet, kullaniciAdi: kullaniciAdi)
    }
}

extension DetailPresenter: InteractorToPresenterDetailProtocol{
    func presenteraVeriGonder(foodsList: [Foods]) {
        detailView?.sendDataToView(foodsList: foodsList)
    }
}
