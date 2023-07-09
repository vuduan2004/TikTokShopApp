//
//  ShirtsViewController.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 03/07/2023.
//

import UIKit
import Kingfisher

class ShirtsViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var cvShirt: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shirtsData: [ProductModel] = []
    var filteredShirtsData: [ProductModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        cvShirt.dataSource = self
        cvShirt.delegate = self
        searchBar.delegate = self
        
        
        cvShirt.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCellIdentifier")
        callAPIGetProducts()
    }
    
    func callAPIGetProducts() {
        APIHandler.init().getShirts{
            productResponseData in
            self.shirtsData = productResponseData
            self.filteredShirtsData = self.shirtsData
            self.cvShirt.reloadData()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredShirtsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvShirt.dequeueReusableCell(withReuseIdentifier: "ProductCellIdentifier", for: indexPath) as! ProductCollectionViewCell
        
        cell.layer.cornerRadius = 5
        cell.lblNameProduct.text = filteredShirtsData[indexPath.row].name
        cell.lblPrice.text = "\(filteredShirtsData[indexPath.row].price)" + " $"
        let imgURL = URL(string: filteredShirtsData[indexPath.row].img)
        cell.imgProduct.kf.setImage(with: imgURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailIdentity") as! DetailViewController
        let product = ProductModel(id: "\(filteredShirtsData[indexPath.row].id)", name: "\(filteredShirtsData[indexPath.row].name)", img: "\(filteredShirtsData[indexPath.row].img)", price: filteredShirtsData[indexPath.row].price, quantity: filteredShirtsData[indexPath.row].quantity, quantityBuy: filteredShirtsData[indexPath.row].quantityBuy, dependencies: "\(filteredShirtsData[indexPath.row].dependencies)")
        detailVC.product = product
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredShirtsData = shirtsData
        } else {
            filteredShirtsData = shirtsData.filter { $0.name.uppercased().contains(searchText.uppercased()) }
        }
        cvShirt.reloadData()
    }
    
    
}

extension ShirtsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 10) / 2 - 0.00001, height: 280)
    }
    
}

