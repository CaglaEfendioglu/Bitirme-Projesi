//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 29.10.2022.
//

import UIKit
import CoreData

class AddressViewController: UIViewController {
    
    //MARK: Views
    
    @IBOutlet weak var tableViewAddress: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    //MARK: Properties
    
    var addressList: [Adres] = []
    let context = appDelegate.persistentContainer.viewContext
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAddress()
    }
    
    //MARK: Private and @IBAction Func
    private func initDelegate() {
        tableViewAddress.dataSource = self
        tableViewAddress.delegate = self
        getAddress()
    }
    
    
    func getAddress() {
        do {
            addressList = try context.fetch(Adres.fetchRequest())
            self.tableViewAddress.reloadData()
        } catch {
            print(error)
        }
    }
    
    
    @IBAction func buttonToAddress(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "addAddress")
        self.show(viewController, sender: nil)
        
    }
    
}

//MARK: UITableViewDelegate, UITableViewDataSource

extension AddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCellAdreslerim
        
        cell.saveUI(adresListesi: addressList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { [weak self]
            (UIContextualAction,view,Bool) in
            guard let self = self else { return }
            let address = self.addressList[indexPath.row]
            let alert = UIAlertController(title: "Uyari", message: "Silmek ister misiniz ?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { _ in
                //core data veri silme
                self.context.delete(address)
                appDelegate.saveContext()
                //core data veri silme
                self.getAddress()
                self.tableViewAddress.reloadData()
            }))
            
            alert.addAction(UIAlertAction(title: "Hayir", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
