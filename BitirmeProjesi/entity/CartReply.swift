//
//  SepetCevap.swift
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 20.10.2022.
//

import Foundation

//MARK: CartFoods

class CartFoods: Codable {
    
    let sepet_yemek_id: String?
    let yemek_adi: String?
    let yemek_resim_adi: String?
    let yemek_fiyat: String?
    var yemek_siparis_adet: String?
    let kullanici_adi: String?
    
    init(sepet_yemek_id: String, yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String, yemek_siparis_adet: String, kullanici_adi: String) {
        self.sepet_yemek_id = sepet_yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
        self.yemek_siparis_adet = yemek_siparis_adet
        self.kullanici_adi = kullanici_adi
    }
}
