//
//  ProductModel.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 03/07/2023.
//

import Foundation

struct ProductModel: Codable {
    var id: String
    var name: String
    var img: String
    var price: Double
    var quantity: Int
    var quantityBuy: Int
    var dependencies: String
    
    init(id: String, name: String, img: String, price: Double, quantity: Int, quantityBuy: Int, dependencies: String) {
        self.id = id
        self.name = name
        self.img = img
        self.price = price
        self.quantity = quantity
        self.quantityBuy = quantityBuy
        self.dependencies = dependencies
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case img = "img"
        case price = "price"
        case quantity = "quantity"
        case quantityBuy = "quantityBuy"
        case dependencies = "dependencies"
    }
    
    
}

typealias Products = [ProductModel]


