//
//  AnasayfaInteractor.swift
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 18.10.2022.
//

import Foundation
import Alamofire

class HomePageInteractor: PresenterToInteractorHomePageProtocol {
    var homePagePresenter: InteractorToPresenterHomePageProtocol?
    
    func takeAllTheFood() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response{ response in
            if let data = response.data {
                do{
                    let reply = try JSONDecoder().decode(FoodsReply.self, from: data)
                    if let list = reply.yemekler{
                        self.homePagePresenter?.sendDataToPresenter(foodsList: list)
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
