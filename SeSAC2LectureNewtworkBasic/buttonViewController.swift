//
//  buttonViewController.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/07/28.
//

import UIKit

class buttonViewController: UIViewController {
    
    static let identifier = "buttonViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    

    @IBAction func buttonTapped(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: WebViewController.identifier) as! WebViewController
        let nv = UINavigationController(rootViewController: vc)

        nv.modalPresentationStyle = .automatic
        self.present(nv, animated: true)
    }


}
