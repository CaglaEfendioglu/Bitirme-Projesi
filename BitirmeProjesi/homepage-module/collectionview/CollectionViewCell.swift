//
//  CollectionViewCell.swift
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 18.10.2022.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDetay: UILabel!
    
    func saveUI(data: Foods) {
        let yemekResimAdi = data.yemek_resim_adi ?? ""
        let urlImage = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemekResimAdi)")
        imageView.kf.setImage(with: urlImage)
        labelName.text = data.yemek_adi
        labelPrice.text = "\(data.yemek_fiyat!) ₺"
        
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = 1
        
        contentView.layer.cornerRadius  = 30
        
        labelDetay.text = "Detay icin tiklayin"
    }
}
