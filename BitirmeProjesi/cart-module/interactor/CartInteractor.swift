//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 29.10.2022.
//

import Foundation
import Alamofire

class CartInteractor: PresenterToInteractorCartProtocol {
    var cartPresenter: InteractorToPresenterCartProtocol?
    var userName = ""
    var sepetList: [CartFoods] = []
    
    func cartTakeAllTheFood(userName: String) {
        let params: Parameters = ["kullanici_adi": userName]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response{ response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(SepetCevap.self, from: data)
                    if let liste = cevap.sepet_yemekler{
                        self.cartPresenter?.sendDataToPresenter(foodsList: liste)
                    }
                    
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func cartDeleteAllFood(id: Int, userName: String) {
        let params: Parameters = ["sepet_yemek_id": id,
                                  "kullanici_adi": userName
        ]
        self.userName = userName
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response{ response in
            if let data = response.data {
                do{
                    let reply = try JSONDecoder().decode(SepetCevap.self, from: data)
                    if let list = reply.sepet_yemekler{
                        self.sepetList = list
                    }
                    if self.sepetList.count != 1 {
                        self.cartTakeAllTheFood(userName: self.userName)
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
