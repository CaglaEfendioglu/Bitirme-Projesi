//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 29.10.2022.
//

import UIKit

class OrderViewController: UIViewController {
    
    //MARK: Views
    
    @IBOutlet weak var tableviewOrder: UITableView!
    
    //MARK: Properties
    
    var orderList: [Orders] = []
    let context = appDelegate.persistentContainer.viewContext
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        siparisGetir()
    }
    
    //MARK: Private and @IBAction Func
    
    private func initDelegate() {
        tableviewOrder.delegate = self
        tableviewOrder.dataSource = self
        
        siparisGetir()
    }
    
    private func siparisGetir() {
        do {
            orderList = try context.fetch(Orders.fetchRequest())
            self.tableviewOrder.reloadData()
        } catch {
            print(error)
        }
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCellSiparislerim
        
        cell.saveUI(yemekListesi: orderList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { [weak self]
            (UIContextualAction,view,Bool) in
            guard let self = self else { return }
            let siparis = self.orderList[indexPath.row]
            let alert = UIAlertController(title: "Uyari", message: "Silmek ister misiniz ?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { _ in
                //Core Data veri silme
                self.context.delete(siparis)
                appDelegate.saveContext()
                //Core Data veri silme
                self.siparisGetir()
                self.tableviewOrder.reloadData()
            }))
            
            alert.addAction(UIAlertAction(title: "Hayir", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
