//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 1.11.2022.
//

import UIKit

class PayViewController: UIViewController {
    @IBOutlet weak var cartNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func payButton(_ sender: Any) {
        if let message = cartNumber.text {
            let alert = UIAlertController(title: "Siparis alindi", message: "\(message) numarali karttan odeme alindi", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
        self.dismiss(animated: true)
    }
}
