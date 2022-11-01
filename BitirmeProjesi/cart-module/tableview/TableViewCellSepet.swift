//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 20.10.2022.
//

import UIKit

class TableViewCellSepet: UITableViewCell {
    
    //MARK: Views
    
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var cartFoodName: UILabel!
    @IBOutlet weak var cartFoodPrice: UILabel!
    @IBOutlet weak var cartFoodNum: UILabel!
    @IBOutlet weak var cartPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func saveUI(cartFoods: CartFoods) {
        cartFoodName.text = cartFoods.yemek_adi ?? ""
        cartFoodPrice.text = "\(cartFoods.yemek_fiyat!) ₺"
        cartFoodNum.text = "\(cartFoods.yemek_siparis_adet!) Adet"
        if let piece = Int(cartFoods.yemek_siparis_adet ?? ""),  let price = Int(cartFoods.yemek_fiyat ?? "") {
            cartPrice.text = "\(piece * price) ₺"
        }
        
        let urlImage = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(cartFoods.yemek_resim_adi ?? "")")
        cartImageView.kf.setImage(with: urlImage)
    }
}
