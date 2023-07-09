//
//  InfoOderViewController.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 06/07/2023.
//

import UIKit
import Kingfisher

class InfoOderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var product: ProductModel?
    var arrProduct: Products = []
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblTotalMoney: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var tblListOder: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblListOder.dataSource = self
        tblListOder.delegate = self
        tblListOder.register(UINib(nibName: "SearchProductTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchProductCellIdentifier")
        
        
        if let product = self.product {
            lblTotalMoney.text = "\(product.price) $"
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblListOder.dequeueReusableCell(withIdentifier: "SearchProductCellIdentifier") as! SearchProductTableViewCell
        if let product = self.product {
            cell.lblName.text = product.name
            cell.lblPrice.text = "\(product.price) $"
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnPay(_ sender: UIButton) {
        if let product = self.product {
            let newProduct = ProductModel(id: product.id, name: product.name, img: product.img, price: product.price, quantity: product.quantity, quantityBuy: product.quantityBuy, dependencies: product.dependencies)
            
            if let data = UserDefaults.standard.data(forKey: "saveOder") {
                if let products = try? JSONDecoder().decode(Products.self, from: data) {
                    arrProduct = products
                }
            }
            
            arrProduct.append(newProduct)
            
            if let encoded = try? JSONEncoder().encode(arrProduct) {
                UserDefaults.standard.set(encoded, forKey: "saveOder")
            }
            let alert = UIAlertController(title: "Thanh toán thành công", message: "Cảm ơn bạn đã mua hàng tại TikTokShop!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
}
