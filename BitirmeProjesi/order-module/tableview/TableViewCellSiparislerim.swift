//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 29.10.2022.
//

import UIKit

class TableViewCellSiparislerim: UITableViewCell {
    
    @IBOutlet weak var ordersImage: UIImageView!
    @IBOutlet weak var orderFoodPrice: UILabel!
    @IBOutlet weak var orderFoodName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func saveUI(yemekListesi: Orders) {
        orderFoodName.text = yemekListesi.yemekAdi ?? ""
        orderFoodPrice.text = "\(yemekListesi.yemekFiyat ?? "") ₺"
        dateLabel.text = yemekListesi.tarih
        
        
        let urlImage = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemekListesi.yemekResimAdi ?? "")")
        ordersImage.kf.setImage(with: urlImage)
    }
}
