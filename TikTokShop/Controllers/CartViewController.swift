//
//  CartViewController.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 05/07/2023.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var btnPay: UIButton!
    var arrProduct: Products = []
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var tblCart: UITableView!
    var quantityBuy: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblCart.dataSource = self
        tblCart.delegate = self
        btnPay.layer.cornerRadius = 5
        
        if let data = UserDefaults.standard.data(forKey: "saveData") {
            if let products = try? JSONDecoder().decode(Products.self, from: data) {
                arrProduct = products
            }
        }
        tblCart.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartCellIdentifier")
        updateTotal()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCellIdentifier", for: indexPath) as! CartTableViewCell
        let product = arrProduct[indexPath.row]
        cell.imgProduct.kf.setImage(with: URL(string: product.img))
        cell.lblName.text = product.name
        cell.lblPrice.text = "$\(product.price)"
        cell.lblQuantity.text = "\(product.quantity) sản phẩm sẵn có"
        cell.quantityBuy = 1
        cell.maxQuantity = product.quantity
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func updateTotal() {
        let totalPrice = calculateTotalPrice()
        lblTotalPrice.text = "$\(totalPrice)"
        lblTotal.text = "\(arrProduct.count) sản phẩm"
    }
    func calculateTotalPrice() -> Double {
        var totalPrice = 0.0
        for product in arrProduct {
            totalPrice += Double(product.price)
        }
        return totalPrice
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrProduct.remove(at: indexPath.row)
            UserDefaults.standard.set(try? JSONEncoder().encode(arrProduct), forKey: "saveData")
            tableView.reloadData()
            let totalPrice = calculateTotalPrice()
            lblTotalPrice.text = "$\(totalPrice)"
            lblTotal.text = "\(arrProduct.count) sản phẩm"
        }
    }
    @IBAction func btnPayAll(_ sender: UIButton) {
        var oderProducts: Products = []
        for product in arrProduct {
            let newProduct = ProductModel(id: product.id, name: product.name, img: product.img, price: product.price, quantity: product.quantity, quantityBuy: product.quantityBuy, dependencies: product.dependencies)
            oderProducts.append(newProduct)
        }
        
        if let encoded = try? JSONEncoder().encode(oderProducts) {
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
