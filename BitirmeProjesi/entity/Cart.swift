//
//  Sepet.swift
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 20.10.2022.
//

import Foundation

//MARK: CartReply

struct SepetCevap: Codable {
    let sepet_yemekler: [CartFoods]?
    let success: Int?
}

