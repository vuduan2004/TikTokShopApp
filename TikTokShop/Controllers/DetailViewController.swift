
//  DetailViewController.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 05/07/2023.
//

import UIKit
import Kingfisher


class DetailViewController: UIViewController {
    var product = ProductModel(id: "", name: "", img: "", price: 1, quantity: 1, quantityBuy: 1, dependencies: "")
    var arrProduct: Products = []
    var productsData: [ProductModel] = []
    
    @IBOutlet weak var dependencies: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgURL = URL(string: product.img)
        self.imgProduct.kf.setImage(with: imgURL)
        self.name.text = product.name
        self.price.text = "\(product.price)" + " $"
        self.dependencies.text = product.dependencies
    }
    
    @IBAction func btnAddToCart(_ sender: UIButton) {
        
        let newProduct = ProductModel(id: product.id, name: product.name, img: product.img, price: product.price, quantity: product.quantity, quantityBuy: product.quantityBuy, dependencies: product.dependencies)
        
        if let data = UserDefaults.standard.data(forKey: "saveData") {
            if let products = try? JSONDecoder().decode(Products.self, from: data) {
                arrProduct = products
            }
        }
        
        arrProduct.append(newProduct)
        
        if let encoded = try? JSONEncoder().encode(arrProduct) {
            UserDefaults.standard.set(encoded, forKey: "saveData")
        }
        
        let alert = UIAlertController(title: "Success", message: "Product has been added to cart.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    @IBAction func btnBuy(_ sender: UIButton) {
        performSegue(withIdentifier: "showInfo", sender: product)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfo" {
            if let infoOderVC = segue.destination as? InfoOderViewController {
                if let product = sender as? ProductModel {
                    infoOderVC.product = product
                }
            }
        }
    }
}

