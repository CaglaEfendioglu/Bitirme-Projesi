//
//  Yemekler.swift
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 19.10.2022.
//

import Foundation


//MARK: Foods

class Foods: Codable {
    var yemek_id:String?
    var yemek_adi:String?
    var yemek_resim_adi:String?
    var yemek_fiyat:String?
    
    init(yemek_id:String,yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:String){
        self.yemek_id = yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
    }
    
}

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let greeting: String?
    let instructions: [String]?
}
