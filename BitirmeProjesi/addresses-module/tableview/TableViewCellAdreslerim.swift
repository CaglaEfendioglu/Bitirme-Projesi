//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 29.10.2022.
//

import UIKit

class TableViewCellAdreslerim: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func saveUI(adresListesi: Adres) {
        cityLabel.text = adresListesi.baslik ?? ""
        addressLabel.text = adresListesi.adres ?? ""
    }
}
