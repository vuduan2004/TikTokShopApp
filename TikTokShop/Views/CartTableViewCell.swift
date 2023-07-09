//
//  CartTableViewCell.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 05/07/2023.
//

import UIKit


class CartTableViewCell: UITableViewCell {
    var quantityBuy: Int = 0
     var maxQuantity: Int = 0
    
    @IBOutlet weak var lblWaring: UILabel!
    @IBOutlet weak var lblQuantityBuy: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        lblWaring.isHidden = true
    }
    
    
    @IBAction func btnReduce(_ sender: UIButton) {
        // Giảm số lượng sản phẩm mua
        if quantityBuy > 1 {
            quantityBuy -= 1
            lblQuantityBuy.text = "\(quantityBuy)"
            lblWaring.isHidden = true
        }
    }

    @IBAction func btnIncrease(_ sender: UIButton) {
        // Tăng số lượng sản phẩm mua
        if quantityBuy < maxQuantity {
            quantityBuy += 1
            lblQuantityBuy.text = "\(quantityBuy)"
            lblWaring.isHidden = true
        } else {
            lblWaring.isHidden = false
        }
    }
}
