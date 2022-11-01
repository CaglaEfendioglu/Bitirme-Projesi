//
//  DetayInteractor.swift
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 28.10.2022.
//

import Foundation
import Alamofire

class DetailInteractor: PresenterToInteractorDetailProtocol {
    var detailPresenter: InteractorToPresenterDetailProtocol?
    
    func addFoodToCart(yemekAdi: String, yemekResimAdi: String, yemekFiyat: Int, yemekSiparisAdet: Int, kullaniciAdi: String) {
        let params: Parameters = ["yemek_adi": yemekAdi,
                                         "yemek_resim_adi": yemekResimAdi,
                                         "yemek_fiyat": yemekFiyat,
                                         "yemek_siparis_adet": yemekSiparisAdet,
                                         "kullanici_adi": kullaniciAdi
                                 ]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response{ response in
            if let data = response.data {
                do{
                    let reply = try JSONDecoder().decode(SepetCevap.self, from: data)
                    if let list = reply.sepet_yemekler{

                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
