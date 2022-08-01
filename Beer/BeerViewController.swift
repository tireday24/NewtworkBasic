//
//  BeerViewController.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/08/01.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON




class BeerViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgURLImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var beerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestApi()
        view.backgroundColor = .yellow
        descriptioDesign()
        nameDesign()
        buttonDesign()
        
        
    }
    
    func descriptioDesign() {
        descriptionLabel.numberOfLines = 0
        nameLabel.layer.borderWidth = 1
        
    }
    
    func nameDesign() {
        nameLabel.textAlignment = .center
        nameLabel.layer.borderWidth = 1
        nameLabel.clipsToBounds = true
    }
    
    func buttonDesign() {
        beerButton.setTitle("Change", for: .normal)
        beerButton.setTitleColor(.black, for: .normal)
        beerButton.layer.borderWidth = 1
    }
    
    func requestApi() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let beerName = json[0]["name"].stringValue
            
                let beerImage = json[0]["image_url"].stringValue
                let randomImage = URL(string: beerImage)
                self.imgURLImageView.kf.setImage(with: randomImage)
            
                let description = json[0]["description"].stringValue
                
            
                self.nameLabel.text = beerName
                self.imgURLImageView.image = UIImage(named: beerImage)
                self.descriptionLabel.text = description
                

            case .failure(let error):
                print(error)
            }
    
}
    }
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        requestApi()
    }
    
    
}
