//
//  HomeViewController.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 03/07/2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var BarItemAccount: UITabBarItem!
    @IBOutlet weak var TabBarHome: UITabBar!
    @IBOutlet weak var lblNew: UILabel!
    @IBOutlet weak var cvSPHot: UICollectionView!
    
    @IBOutlet weak var btnHandBag: UIButton!
    @IBOutlet weak var btnScandal: UIButton!
    @IBOutlet weak var btnShoe: UIButton!
    @IBOutlet weak var btnTrousers: UIButton!
    @IBOutlet weak var btnShirt: UIButton!
    @IBOutlet weak var viewBackgroundWhite: UIView!
    @IBOutlet weak var viewBackgroundBlack: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    
    
    
    var spHotData: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cvSPHot.dataSource = self
        cvSPHot.delegate = self
        
        
        let spNew = UICollectionViewFlowLayout()
        spNew.scrollDirection = .horizontal
        cvSPHot.collectionViewLayout = spNew
        
        btnSearch.layer.cornerRadius = 17
        btnShirt.layer.cornerRadius = 10
        btnTrousers.layer.cornerRadius = 10
        btnShoe.layer.cornerRadius = 10
        btnScandal.layer.cornerRadius = 10
        btnHandBag.layer.cornerRadius = 10
        
        viewBackgroundWhite.layer.shadowColor = UIColor.black.cgColor
        viewBackgroundWhite.layer.shadowOpacity = 0.5
        viewBackgroundWhite.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewBackgroundWhite.layer.shadowRadius = 5
        viewBackgroundWhite.layer.cornerRadius = 20
        viewBackgroundBlack.layer.cornerRadius = 50
        
        lblNew.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        UIView.animate(withDuration: 0.2, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.lblNew.alpha = 0
        }, completion: nil)
        
        
        cvSPHot.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCellIdentifier")
        callAPIGetProducts()
        
        
    }
    
    
    @IBAction func btnItemAccount(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoUserVC = storyboard.instantiateViewController(withIdentifier: "InFoUserViewController") as! InFoUserViewController
        
        navigationController?.setViewControllers([infoUserVC], animated: false)
        
        infoUserVC.navigationItem.hidesBackButton = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func callAPIGetProducts() {
        APIHandler.init().getSPHots{
            productResponseData in
            self.spHotData = productResponseData
            self.cvSPHot.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spHotData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvSPHot.dequeueReusableCell(withReuseIdentifier: "ProductCellIdentifier", for: indexPath) as! ProductCollectionViewCell
        
        
        cell.layer.cornerRadius = 5
        cell.lblNameProduct.text = spHotData[indexPath.row].name
        cell.lblPrice.text = "\(spHotData[indexPath.row].price)" + " $"
        let imgURL = URL(string: spHotData[indexPath.row].img)
        cell.imgProduct.kf.setImage(with: imgURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailIdentity") as! DetailViewController
        let product = ProductModel(id: "\(spHotData[indexPath.row].id)", name: "\(spHotData[indexPath.row].name)", img: "\(spHotData[indexPath.row].img)", price: spHotData[indexPath.row].price, quantity: spHotData[indexPath.row].quantity, quantityBuy: spHotData[indexPath.row].quantityBuy, dependencies: "\(spHotData[indexPath.row].dependencies)")
        detailVC.product = product
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 185
        let cellHeight: CGFloat = 300
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
