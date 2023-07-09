//
//  OderHistoryViewController.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 08/07/2023.
//

import UIKit

class OderHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var arrProduct: Products = []
    var quantityBuy: Int = 0
    
    @IBOutlet weak var tblOderHistory: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblOderHistory.dataSource = self
        tblOderHistory.delegate = self
        
        if let data = UserDefaults.standard.data(forKey: "saveOder") {
            if let products = try? JSONDecoder().decode(Products.self, from: data) {
                arrProduct = products
            }
        }
        
        tblOderHistory.register(UINib(nibName: "SearchProductTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchProductCellIdentifier")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchProductCellIdentifier", for: indexPath) as! SearchProductTableViewCell
        let product = arrProduct[indexPath.row]
        cell.imgSearch.kf.setImage(with: URL(string: product.img))
        cell.lblName.text = product.name
        cell.lblPrice.text = "$\(product.price)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            arrProduct.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let encoded = try? JSONEncoder().encode(arrProduct) {
                UserDefaults.standard.set(encoded, forKey: "saveOder")
            }
        }
    }
}
