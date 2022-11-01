//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 18.10.2022.
//

import UIKit
import Alamofire
import Lottie
import CoreData

class DetailViewController: UIViewController {
    
    //MARK: Views
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var animationView2: LottieAnimationView!
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var labelFoodName: UILabel!
    @IBOutlet weak var labelFoodPrice: UILabel!
    @IBOutlet weak var labelNum: UILabel!
    @IBOutlet weak var labelCalorie: UILabel!
    @IBOutlet weak var textFieldTotalPrice: UITextField!
    
    //MARK: Properties
    
    var food: Foods?
    var counter = 1
    var detailPresenterObject: ViewToPresenterDetailProtocol?
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAnimation()
        setupAnimation2()
        navigationController?.navigationBar.isHidden = false
        DetailRouter.createModule(ref: self)
        setupUI()
   }
    
    //MARK: Private and @IBAction Func

    private func setupAnimation() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
    private func setupAnimation2() {
        animationView2.contentMode = .scaleAspectFit
        animationView2.loopMode = .loop
        animationView2.play()
    }
    
    private func setupUI() {
        if let y = food {
            let urlImage = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi!)")
            imageFood.kf.setImage(with: urlImage)
            labelFoodName.text = y.yemek_adi!
            labelFoodPrice.text = "\(y.yemek_fiyat!) ₺"
            textFieldTotalPrice.text = "\(y.yemek_fiyat!) ₺"
            
            switch y.yemek_adi {
            case "Ayran":
                labelCalorie.text = "80 kCal"
            case "Baklava":
                labelCalorie.text = "350 kCal"
            case "Fanta":
                labelCalorie.text = "400 kCal"
            case "Izgara Somon":
                labelCalorie.text = "350 kCal"
            case "Izgara Tavuk":
                labelCalorie.text = "200 kCal"
            case "Kadayıf":
                labelCalorie.text = "300 kCal"
            case "Kahve":
                labelCalorie.text = "5 kCal"
            case "Köfte":
                labelCalorie.text = "200 kCal"
            case "Lazanya":
                labelCalorie.text = "90 kCal"
            case "Makarna":
                labelCalorie.text = "150 kCal"
            case "Pizza":
                labelCalorie.text = "400 kCal"
            case "Su":
                labelCalorie.text = "0 kCal"
            case "Sütlaç":
                labelCalorie.text = "225 kCal"
            case "Tiramisu":
                labelCalorie.text = "390 kCal"
            default:
                labelCalorie.text = ""
            }
       }
    }
    
   private func addToCart(yemekAdi: String, yemekResimAdi: String, yemekFiyat: Int, yemekSiparisAdet: Int, kullaniciAdi: String) {
        detailPresenterObject?.addToCart(yemekAdi: yemekAdi, yemekResimAdi: yemekResimAdi, yemekFiyat: yemekFiyat, yemekSiparisAdet: yemekSiparisAdet, kullaniciAdi: kullaniciAdi)
    }
    
    @IBAction func buttonAddToCart(_ sender: Any) {
        if let yemekAdi = food?.yemek_adi, let yemekResimAdi = food?.yemek_resim_adi, let yemekFiyatInt = Int(food?.yemek_fiyat ?? "") {
            
            addToCart(yemekAdi: yemekAdi, yemekResimAdi: yemekResimAdi, yemekFiyat: yemekFiyatInt, yemekSiparisAdet: counter, kullaniciAdi: "caglaefendioglu")
            
            let alert = UIAlertController(title: "Mesaj", message: "Sepete eklendi", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: nil))
            
            present(alert, animated: true)
        }
    }
    
    @IBAction func buttonPlus(_ sender: Any) {
        counter += 1
        labelNum.text = String(counter)
        
        if let y = food {
            if let a = Int(y.yemek_fiyat!), let b = Int(labelNum.text!) {
                textFieldTotalPrice.text = "\(a*b) ₺"
            }
        }
    }
    
    @IBAction func buttonMinus(_ sender: Any) {
        if counter <= 1 {
            counter = 1
            labelNum.text = String(counter)
            
        }
        else {
            counter -= 1
            labelNum.text = String(counter)
            
        }
        if let y = food {
            if let a = Int(y.yemek_fiyat!), let b = Int(labelNum.text!) {
                textFieldTotalPrice.text = "\(a*b) ₺"
            }
        }
    }
}

extension DetailViewController: PresenterToViewDetailProtocol{
    func sendDataToView(foodsList: [Foods]) {
    }
}
