//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 30.10.2022.
//

import UIKit
import CoreData

class AddToAddressViewController: UIViewController {
    
    //MARK: Views
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    //MARK: Properties
    
    let context = appDelegate.persistentContainer.viewContext
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.hidesBackButton = false
    }
    
    //MARK: Private and @IBAction Func
    
    @IBAction func addToAddressButton(_ sender: Any) {
        if let address = addressTextField.text, let name = nameTextField.text, let surname = surnameTextField.text, let telefon = phoneTextField.text, let baslik = titleTextField.text {
            
            if !address.isEmpty && !name.isEmpty && !surname.isEmpty && !telefon.isEmpty && !baslik.isEmpty {
                let adresListesi = Adres(context: context)
                adresListesi.adres = address
                adresListesi.ad = name
                adresListesi.soyad = surname
                adresListesi.telefon = telefon
                adresListesi.baslik = baslik
                appDelegate.saveContext()
                self.navigationController?.popViewController(animated: true)
            }else{
                let alert = UIAlertController(title: "Uyari", message: "Eksik alanlar var", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: nil))
                present(alert, animated: true)
            }
        }
        self.dismiss(animated: true)
    }
}
