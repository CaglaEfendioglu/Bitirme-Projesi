//
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 18.10.2022.
//

import UIKit
import Kingfisher

class HomePageViewController: UIViewController {
    
    //MARK: Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sortButton: UIButton!
    
    //MARK: Properties
    
    var foodList: [Foods] = []
    var foodListSecond = [Foods]()
    var sortedData: [Foods] = []
    var isSearch = false
    var isSort = false
    var homePagePresenterObject: ViewToPresenterHomePageProtocol?
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegate()
        HomePageRouter.createModule(ref: self)
        sortButton.setTitle("Azalan Fiyat", for: .normal)
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homePagePresenterObject?.takeFood()
    }
    
    //MARK: Private and @IBAction Func
    
    private func initDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        collectionLayout()
    }
    
    private func collectionLayout() {
        let layout = UICollectionViewFlowLayout()
        let width = self.collectionView.frame.size.width
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let cellWidth = (width-30)/2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth*1.25)
        collectionView!.collectionViewLayout = layout
    }
    
    @IBAction func buttonSort(_ sender: Any) {
        sortBy()
        if isSort {
            isSort = false
            sortButton.setTitle("Azalan Fiyat", for: .normal)
            
        }else{
            isSort = true
            sortButton.setTitle("Siralamayi Kaldir", for: .normal)
        }
        self.collectionView.reloadData()
        
    }
    
    func sortBy() {
        var bool = false
        if isSearch {
            sortedData = foodListSecond.sorted {
                if let x = Int($0.yemek_fiyat ?? ""), let y =  Int($1.yemek_fiyat ?? "") {
                    bool = x > y
                    return x > y
                }
                return bool
            }
        }else {
            sortedData = foodList.sorted {
                if let x = Int($0.yemek_fiyat ?? ""), let y =  Int($1.yemek_fiyat ?? "") {
                    bool = x > y
                    return x > y
                }
                return bool
            }
        }
    }
}

//MARK: PresenterToViewHomePageProtocol

extension HomePageViewController: PresenterToViewHomePageProtocol{
    func sendDataToView(foodsList: [Foods]) {
        self.foodList = foodsList
        isSearch =  false
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//MARK: UISearchBarDelegate

extension HomePageViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            homePagePresenterObject?.takeFood()
        }else{
            if isSort {
                foodListSecond = sortedData.filter({($0.yemek_adi ?? "").lowercased().contains(searchText.lowercased())})
            }else{
                foodListSecond = foodList.filter({($0.yemek_adi ?? "").lowercased().contains(searchText.lowercased())})
            }
            
            isSearch =  true
        }
        
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        homePagePresenterObject?.takeFood()
        isSearch = false
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
}


//MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearch {
            return foodListSecond.count
        }else{
            if isSort {
                return sortedData.count
            }else{
                return foodList.count
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gelenYemek = foodList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodsCollectionviewCell", for: indexPath) as! CollectionViewCell
        
        if isSearch {
            let fromFood = foodListSecond[indexPath.row]
            cell.saveUI(data: fromFood)
        }else{
            if isSort {
                let foodList = sortedData[indexPath.row]
                cell.saveUI(data: foodList)
            }else{
                cell.saveUI(data: gelenYemek)
            }
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var fromFood = foodList[indexPath.row]
        if isSearch {
            fromFood = foodListSecond[indexPath.row]
        }else{
            if isSort {
                fromFood = sortedData[indexPath.row]
            }else{
                fromFood = foodList[indexPath.row]
            }
        }
        performSegue(withIdentifier: "toDetail", sender: fromFood)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let food = sender as? Foods {
                let VC = segue.destination as! DetailViewController
                VC.food = food
            }
        }
    }
}
