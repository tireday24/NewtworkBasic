//
//  TranslateViewController.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {
    
    //UIButton, UITextField -> Action
    //UITextView, UISearchBar, UIPickerView -> x
    //왜? -> contorl 채택 x
    //여러 줄 작성 가능 -> TextView
    // UIControl > 상속? action 구현 가능
    // UIResponderChain > apple문서, 블로그, responder chain -> 어떤 친구를 선택했는지 알려주는
    // -> resignFirstResponder(), userInputTextView.becomeFirstResponder()
    // 뷰객체가 어떤 쪽 까지 반응을 전달해줄거냐
    @IBOutlet weak var userInputTextView: UITextView!
    @IBOutlet weak var translateTextView: UITextView!
    
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        //텍스트 뷰에서 placeholder 멤버 없음
        //userInputTextView.placeholder = "dsdsd"
        //delegate 연결이 되어 있어야 호출 가능 기능했을때
        userInputTextView.delegate = self
        
        //키보드 올리고 내리고
        //userInputTextView.resignFirstResponder()
        //userInputTextView.becomeFirstResponder()
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        
        //열거형이나 타입프로퍼티 활용해서 써라 모빌리티쪽은 네비게이션에서 필요 없는 글자를 지워서 용량을 줄인다
        userInputTextView.font = UIFont(name: "S-CoreDream-3Light", size: 17)
        translateTextView.textColor = .black
        
        //requestTranslateData()
   
    }
    
    func requestTranslateData() {
        let url = EndPoint.translateURL
        
        let parameter = ["source": "ko", "target": "ja", "text": "\(userInputTextView.text!)"]
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        //헤더 활용
        AF.request(url, method: .post, parameters: parameter, headers: header).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let translateData = json["message"]["result"]["translatedText"].stringValue
                self.translateTextView.text = translateData
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    
                } else {
                    self.userInputTextView.text = json["errorMessage"].stringValue
                }

            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @IBAction func traslateButtonClicked(_ sender: UIButton) {
        requestTranslateData()
    }
    
    
}

extension TranslateViewController: UITextViewDelegate {
    
    //글자가 변할 때 마다 호출 -> 자소서 앱에서 글자 입력할때마다 바뀔때
//    func textViewDidChange(_ textView: UITextView) {
//        print(textView.text.count)
//    }
    
    //커서가 깜빡이기 시작할 때 , 편집이 시작될 때
    //텍스트뷰 글자: 플레이스 홀더랑 글자가 같으면 clear , color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    
    //텍스트 뷰 편집이 끝났을 때 -> 커서가 없어지는 순간
    //편집 끝내는 제일 쉬운 방법 다른 뷰객체로 넘어가야 끝난다
    //텍스트뷰 글자: 사용자가 아무 글자도 안쓰면 플레이스 홀더 글자 보이게 해라
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        // textView.text.isEmpty or nil
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
        
    }
}
