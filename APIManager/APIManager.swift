//
//  APIManager.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/08/07.
//

import UIKit

import Alamofire
import SwiftyJSON

class APIManager {
    private init() {}
    static let shared = APIManager()
    
//    func requestLotto(number: Int, lottoNumber: [UILabel]) {
//        
//        let ud = UserDefaults.standard
//        
//        if ud.stringArray(forKey: "\(number)") != nil {
//            
//        }
//        
//        //AF: 200 ~ 299 status code
//        // number => 회차 1026 +7 할 때 마다 -> 이렇게 짜면 Date + 7 할때마다 회차 하나 올림
//        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
//        
//        //접두어 -> AF 알라모파이어에서 url주소로 들어가고 get 방식 유효성 검사(상태코드) 실행 ex) 200 = 성공 response 데이터 가져오겠다
//        AF.request(url, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//                
//                var lottoList: [String] = []
//                
//                let date = json["drwNoDate"].stringValue
//                let bonus = json["bnusNo"].stringValue
//                
//                for num in 0...5 {
//                    lottoList.append(String(json["drwtNo\(num+1)"].intValue))
//                }
//                
//                
//                
//                //명확하게 클래스 내부에 있다 self
//                print("==1==")
//                self.numberTextField.text = date
//                self.bonusNumber.text = bonus
//                
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
}
