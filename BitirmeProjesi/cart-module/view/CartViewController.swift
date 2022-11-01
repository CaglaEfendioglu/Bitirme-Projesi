//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 19.10.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class CartViewController: UIViewController {
    
    //MARK: Views
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    
    //MARK: Properties
    
    var cartFoods: [CartFoods] = []
    var cartFoodsList: [CartFoods] = []
    var cartPresenterObject: ViewToPresenterCartProtocol?
    let context = appDelegate.persistentContainer.viewContext
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        CartRouter.createModule(ref: self)
        cartPresenterObject?.cartTakeFood(userName: "caglaefendioglu")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartPresenterObject?.cartTakeFood(userName: "caglaefendioglu")
    }
    
    //MARK: Private and @IBAction Func
    
    private func initDelegate() {
        cartTableView.delegate = self
        cartTableView.dataSource = self
    }
    
    @IBAction func siparisVer(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let todayDate = dateFormatter.string(from: .now)
        
        for i in cartFoodsList {
            if let foodName = i.yemek_adi, let foodImageName = i.yemek_resim_adi, let foodPrice = i.yemek_fiyat {
                let orderList = Orders(context: context)
                orderList.yemekAdi = foodName
                orderList.yemekFiyat = foodPrice
                orderList.yemekResimAdi = foodImageName
                orderList.tarih = todayDate
               
            }
            appDelegate.saveContext()
        }

    }
    
    private func foodEdit(food: [CartFoods]) {
        var foodName: [String] = []
        var pieceCount = 0
        cartFoodsList.removeAll()
        
        for (index,i) in food.enumerated() {
            for i in cartFoodsList {
                foodName.append(i.yemek_adi!)
            }
            
            switch index {
            case 0:
                cartFoodsList.append(i)
            default:
                if food[index].yemek_adi != food[index - 1].yemek_adi && foodName.contains(food[index].yemek_adi ?? "") == false {
                    cartFoodsList.append(food[index])
                }else{
                    for b in cartFoodsList {
                        if food[index].yemek_adi == b.yemek_adi {
                            pieceCount = 0
                            pieceCount += Int(food[index].yemek_siparis_adet ?? "") ?? 0
                            guard let pieceString = b.yemek_siparis_adet else { return }
                            guard var piece = Int(pieceString) else { return }
                            piece += pieceCount
                            for (index, _) in cartFoodsList.enumerated() {
                                if cartFoodsList[index].yemek_adi == b.yemek_adi {
                                    cartFoodsList[index].yemek_siparis_adet = String(piece)
                                }
                            }
                        }
                    }
                }
            }
        }
        var cartPrice =  0
        for i in cartFoodsList {
            if let price = Int(i.yemek_fiyat ?? ""), let cardpiece = Int(i.yemek_siparis_adet ?? "") {
                cartPrice += (price * cardpiece)
                self.totalPrice.text = "\(cartPrice) ₺"
            }
        }
    }
}

//MARK: PresenterToViewCartProtocol

extension CartViewController: PresenterToViewCartProtocol{
    func sendDataToView(foodList: [CartFoods]) {
        self.cartFoods = foodList
        foodEdit(food: foodList)
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartFoodsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCellSepet
        
        cell.saveUI(cartFoods: cartFoodsList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { [weak self]
            (UIContextualAction,view,Bool) in
            guard let self = self else { return }
            let foodName =   self.cartFoodsList[indexPath.row].yemek_adi
            guard let userName = self.cartFoodsList[indexPath.row].kullanici_adi else { return }
            
            let alert = UIAlertController(title: "Uyari", message: "Silmek ister misiniz ?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { _ in
                if indexPath.row == 0 {
                    for i in self.cartFoods {
                        if i.yemek_adi == foodName {
                            let id = Int(i.sepet_yemek_id ?? "")
                            self.cartPresenterObject?.cartFoodDelete(id: id ?? 0 , userName: userName)
                        }
                    }
                    self.cartFoodsList.removeAll()
                    self.cartTableView.reloadData()
                }else{
                    for i in self.cartFoods {
                        if i.yemek_adi == foodName {
                            let id = Int(i.sepet_yemek_id ?? "")
                            self.cartPresenterObject?.cartFoodDelete(id: id ?? 0 , userName: userName)
                        }
                    }
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Hayir", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

