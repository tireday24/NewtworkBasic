//
//  SearchViewController.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/07/27.
//

import UIKit
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

//프로토콜 내에 받는 요소들을 꼭 준수를 해라
class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchTableView: UITableView!
    
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
        searchTableView.register(UINib(nibName: ListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)

    }
    
    //viewDidLoad 하단에서 사용 가능
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "HELLO"
        cell.backgroundColor = .clear
        
        return cell
    }
    
}
