//
//  SearchProductViewController.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 05/07/2023.
//

import UIKit
import Kingfisher

class SearchProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var imgBox: UIImageView!
    @IBOutlet weak var lblAlert: UILabel!
    var productData: [ProductModel] = []
    var filteredProductData: [ProductModel] = []
    
    var currentSearchText: String?
    @IBOutlet weak var tblProduct: UITableView!
    @IBOutlet weak var searchProduct: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblProduct.dataSource = self
        tblProduct.delegate = self
        searchProduct.delegate = self
        tblProduct.register(UINib(nibName: "SearchProductTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchProductCellIdentifier")
        cellAPIGetNewProduct()
        cellAPIGetShirts()
        tblProduct.isHidden = true
        
    }
    
    func cellAPIGetNewProduct() {
        APIHandler().getSPHots { productResponeData in
            self.productData.append(contentsOf: productResponeData)
            self.filteredProductData = self.productData
            self.tblProduct.reloadData()
        }
    }
    
    func cellAPIGetShirts() {
        APIHandler().getShirts { productResponeData in
            self.productData.append(contentsOf: productResponeData)
            self.filteredProductData = self.productData
            self.tblProduct.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProductData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblProduct.dequeueReusableCell(withIdentifier: "SearchProductCellIdentifier") as! SearchProductTableViewCell
        cell.lblName.text = filteredProductData[indexPath.row].name
        cell.lblPrice.text = "\(filteredProductData[indexPath.row].price)" + " $"
        cell.imgSearch.kf.setImage(with: URL(string: filteredProductData[indexPath.row].img))
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredProductData = productData
            tblProduct.isHidden = true
            lblAlert.text = "Danh sách tìm kiếm"
            imgBox.isHidden = true
        } else {
            filteredProductData = productData.filter { $0.name.uppercased().contains(searchText.uppercased()) }
            tblProduct.isHidden = filteredProductData.isEmpty
            lblAlert.text = "Không tìm thấy sản phẩm"
            imgBox.isHidden = false
        }
        tblProduct.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailIdentity") as! DetailViewController
        let product = ProductModel(id: "\(productData[indexPath.row].id)", name: "\(productData[indexPath.row].name)", img: "\(productData[indexPath.row].img)", price: productData[indexPath.row].price, quantity: productData[indexPath.row].quantity, quantityBuy: productData[indexPath.row].quantityBuy, dependencies: "\(productData[indexPath.row].dependencies)")
        detailVC.product = product
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
    
}
