//
//  SearchProductTableViewCell.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 05/07/2023.
//

import UIKit

class SearchProductTableViewCell: UITableViewCell {

    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
