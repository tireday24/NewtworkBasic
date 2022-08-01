 //
//  LottoViewController.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/07/28.
//

import UIKit
//apple 먼저 한칸 뛰고 외부에서 다운 받은 것 선언 알파벳 순서 1. Import
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {
    
    @IBOutlet weak var numberTextField: UITextField!
    //@IBOutlet weak var lottoPickerView: UIPickerView!
    //pickerview의 델리케이트와 Datasource 연결해줘야한다
    
    //사용하려면 클래스 인스턴스 필수
    //코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있다
    //시뮬에서 옵션 누르면 제스쳐 기능이 나온다 줌 기능 확인할때
    //복붙 방지 -> 투명한 텍스트필드 위에 버튼 올려서 복붙 방지 or 아예 키보드 깜빡이는 커서 방지
    //뷰컨 클린하게 띄우고 아울렛으로 픽커뷰 만들고 탭바 붙임 overfullscreen 방식으로 아래에서 위로
    //텍스트 필드를 보더로 버튼으로 만들면 -> 사용자가 버튼이라 인식 -> 커서 깜빡거리는거 막음
    //sheetVC? -> 꽈차지 않은 뷰인데 에니메이션 넣는 뷰 panmodal
    
    
    @IBOutlet var lottoNumber: [UILabel]!
    @IBOutlet weak var bonusNumber: UILabel!
    
    var lottoPickerView = UIPickerView()
    
    let lottoList: [Int] = Array(1...1025).reversed()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...5 {
            lottoNumber[i].tag = i
        }
        
        //인증번호 자동으로 받기 -> 타입에 맞춰서 알아서 입력됨
        //numberTextField.textContentType = .oneTimeCode
        
        //키보드 올라왔을 때 픽커뷰 보여주고 싶어
        //텍스트필드 누르면 픽커뷰 하나 더 올라옴
        //enter치면 픽커뷰 사라지게하기
        //키보드 안올라옴
        //커서 없앰 -> tintColor clear 텍스트필드 투명으로 놓고 보여졌다 안보여졌다 하게 할수도 있음
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        numberTextField.delegate = self
        
        requestLotto(number: 1025)
        
        labelDesign()

       
    }
    
    func requestLotto(number: Int) {
        
        //AF: 200 ~ 299 status code
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        //접두어 -> AF 알라모파이어에서 url주소로 들어가고 get 방식 유효성 검사(상태코드) 실행 ex) 200 = 성공 response 데이터 가져오겠다
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let date = json["drwNoDate"].stringValue
                let bonus = json["bnusNo"].stringValue
                
                for num in 0...5 {
                    self.lottoNumber[num].text = String(json["drwtNo\(self.lottoNumber[num].tag+1)"].intValue)
                }
                //명확하게 클래스 내부에 있다 self
                self.numberTextField.text = date
                self.bonusNumber.text = bonus
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func labelDesign() {
        for i in lottoNumber {
            i.layer.cornerRadius = 20
            i.clipsToBounds = true
            i.font = .boldSystemFont(ofSize: 20)
            i.backgroundColor = .blue
            i.textAlignment = .center
            i.textColor = .white
            
        }
    }
}

//뷰 객체마다 필요한 프로토콜 익스텐션으로 나눠준다
//따로 파일을 만들고 익스텐션을 넣는 것은 가능하지만, 프로토콜이 많아질수록 파일이 많아져서 controller 안에 만드는게 좋다
extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //옵션 휠 돌아갈때 몇개?
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //component 갯수
        return lottoList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //멈추는 시점
        requestLotto(number: lottoList[row])
        //numberTextField.text = "\(lottoList[row])회차"
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //각각의 열마다 어떤 글자?
        return "\(lottoList[row])회차"
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.isUserInteractionEnabled = false
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.isUserInteractionEnabled = true
    }
    
}


