//
//  SearchViewController.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON
import JGProgressHUD

/*
 Swift Protocol
 - Delegate
 - DataSource
 
 1. 왼팔/오른팔
 2. 테이블뷰 아울렛 연결
 3. 1 + 2 프로토콜 요소에 연결해주었다
 */


//extension UIViewController {
//    func setBackgroundColor() {
//        view.backgroundColor = .red
//    }
//}
// -> viewController를 상속 받기 때문에 한번에 일괄로 받을 수 있다

/*
 0802
 각 jsonValue -> list -> 테이블 갱신
 서버의 응답이 몇개인지 모를 경우에는?
 
 let movieNm1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
 let movieNm2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
 let movieNm3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
 
 //list 배열에 데이터 추가
 self.list.append(movieNm1)
 self.list.append(movieNm2)
 self.list.append(movieNm3)
 
 */

//프로토콜 내에 받는 요소들을 꼭 준수를 해라
class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var boxOfficeSearchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    //BoxOffice 배열
    var list: [BoxOfficeModel] = []
    //ProgressView
    let hud = JGProgressHUD()
    
    
    //0803 타입 어노테이션 vs 타입 추론 => 누가 더 속도가 빠를까? => 타입 어노테이션 타입 명시를 해주어라
    //What's new in Swift 옛날에 비해 추론의 속도는 빨라지고 있다
    var nickname: String = ""
    var username = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        searchTableView.backgroundColor = .clear
        //중요
        //연결고리 작업: 테이블뷰가 해야할 역할 > 뷰컨틀로러에게 요청
        //테이블뷰가 여러개면 테이블뷰 마다 연결해주어야함
        //클래스 인스턴스 자체
        //delegate 패턴
        searchTableView.delegate = self
        searchTableView.dataSource = self
        //테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        //XIB: xml interface builder <= Nib
        //파일이름 -> 해당 파일의 아이덴티파이어
        //일부분의 화면을 모듈화하는 작업 재활용셀
        //화면을 점점 분리하는 작업을 할거다
        //재사용 재활용할 예정
        //테이블뷰 컨트롤러일때는 안하던거를 직접 지정해주었다
        //자유도가 높다(레이아웃 설정으로 가능)
        
        // 0803 TMI -> "yyyyMMdd" "YYYYMMdd" 소문자 대문자 차이 -> 대문자는 마지막주에 대한 것에 대하여 달라질 수 있다
        // 하루 전 계산 timeInterval
       
        //let format = DateFormatter
        //format.dateFormat = "yyyyMMdd"
        //let dateResult = Date(timeIntervalSinceNow: -86400)
        //let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        //let dateResult = format.string(from: yesterday!)
        //requestBoxOffice(date: dateResult)
        
        //0803 네트워크 통신: 서버 점검 등에 대한 예외 처리
        //네트워크가 느린 환경 테스트: 실기기 테스트 시 condition 조절 가능!
        // 시뮬레이터에서도 가능! (추가 설치) 윈도우 => 디바이스 시뮬레이터 => 디바이스 아래 컨디션 조절 가능 네트워크 속도 제한 가능
        
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        boxOfficeSearchBar.delegate = self
        print("!")
        requestBoxOffice(date: "220801")
        print("?")

    }
    
    //viewDidLoad 하단에서 사용 가능
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func requestBoxOffice(date: String) {
        
        //서버 통신 전에 배열 지우고 나서 시작 로딩바를 띄우기, 데이터의 갯수가 0
        hud.show(in: view)
        list.removeAll()
        
        //AF: 200 ~ 299 status code
        //인증키: 3000회 제한 하루에 사용할 수 있는데에 제한이 있다 사이트 마다 제한 알아보자 제한 범위를 넘어가면 서비스 다운 / 만약 인증키 제한이 하루에 다 끝나면 요청을 해야함
        
        //let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(date)"
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(date)"

        //접두어 -> AF 알라모파이어에서 url주소로 들어가고 get 방식 유효성 검사(상태코드) 실행 ex) 200 = 성공 response 데이터 가져오겠다
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                //데이터 넘어 왔을 때 지움
                self.list.removeAll()
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNm, releaseDate: openDt, totalCount: audiAcc)
                    
                    self.list.append(data)
                }
                
                //리스트 다 넣은 후 갱신 
                self.searchTableView.reloadData()
                //로딩바 지우기
                self.hud.dismiss()
                
            case .failure(let error):
                //실패 했을 때 로딩바 지우기
                self.hud.dismiss()
                print(error)
                
                //시뮬레이터 실패 테스트 > 맥 > 실제 디바이스 테스트
                
            }
        }
        //hud.dismiss() 여기에 호출되면 바로 사라짐 함수만 실행되면 사라진다
        
    }
    
    func yesterday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: .now)!
        return formatter.string(from: yesterday)
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "\(list[indexPath.row].movieTitle): \(list[indexPath.row].releaseDate)"
        cell.backgroundColor = .clear
        
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice(date: yesterday()) // 옵셔널 바인딩, 8글자, 숫자, 날짜로 변경 시 유효한 형태의 값인가
        //text: boxOfficeSearchBar.text!
    }
    
}
