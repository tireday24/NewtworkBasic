//
//  ViewController.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/07/27.
//

import UIKit

class ViewController: UIViewController, viewPresentableProtocol {
    
    //모든 요소를 let으로 쓸 때 보다 느릴 수 있음 모든 조건을 고려하기 때문에 -> let 쓰면 set 못 써서 오류 (get set구현 시)
    
    static var identifier: String = "ViewController"
    
    var navigationTitleString: String {
        get {
            return "대장님의 다마고치"
        }
        set {
            title = newValue
        }
    }
    
    var backgroundColor: UIColor {
        get {
            return .blue
        }
    }
    
    
    func configureView() {
        
        navigationTitleString = "고래밥님의 다마고치"
        //get 밖에 안가져왔는데 세팅 가능하다
        //get만 사용하고 싶으면 let 상수로 표현하면 됨
        //backgroundColor = .red
        
        title = navigationTitleString
        view.backgroundColor = backgroundColor
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UserDefaultsHelper.standard.nickname = "고래밥"
        
        title = UserDefaultsHelper.standard.nickname
        
        UserDefaultsHelper.standard.age = 80
        
        print(UserDefaultsHelper.standard.age)
    }


}

