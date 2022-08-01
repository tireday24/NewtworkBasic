//
//  ViewPresentableProtocol.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/07/28.
//

import Foundation
import UIKit

/*
 ~Protocol
 ~Delegate
 */

//실질적인 기능은 책에서 목차를 빼듯이 구체적으로 사용할 네이밍만 빼와서 사용
//상속받는 곳에 사용 상속받는 클래스 다음에 작성해야한다 어떤 위치든 상관없음
//네이밍도 상당히 중요하다
//프로토콜을 보면 이 프로토콜을 보면 이 특성을 썼겠구나 하고 예상이간다
//실질적인 구현부에서 일일이 다 말해줄 필요없음 프로토콜을 보면 알 수 있다
//실질적인 구현은 프로토콜에서 해주지 않는다
//프로토콜은 규약이자 필요한 요소로 명세만 할 뿐, 실질적인 구현부는 작성하지 않는다
//실질적인 구현은 프로토콜 채택, 준수한 타입이 구현한다
//채택한 곳에서 각각 다르게 구현 가능하다
//class, struct, enum, extension에 사용 가능하다
//주된 기능들이 프로토콜로 이루어짐
//delegate, datasource 또한 프로토콜 어제 오류 안뜬 이유 이미 만들었어서
//테이블뷰는 프로토콜로 규칙을 만들어놓는다(delegate, datasource) 채택한다면 테이블뷰에서 쓸 수 있는 기능을 쓸 수 있게 해주겠다
//class 다중상속이 Swift에서는 안된다 -> collectionView 받으면 tableview의 기능을 상속 받지 못함
//해결점 -> 프로토콜 특정 뷰 객체에 대한 요소를 상속 받아서 사용 가능
//모든 뷰 컨틀로러에서 다 쓴 다면 class 상속이 좋음, 각각 분리된다면 프로토콜로 만들어서 사용하는 것이 적합하다
//클래스는 단일 상속만 가능하지만 프로토콜은 채택 갯수에 제한이 없다
//optional func 필요한 기능이긴한데 쓸수도 있고 안쓸수도 있다 쓰려면 앞에 @objc 써야함 프로토콜 역시 앞에 @objc 붙여줘야한다
//@objc optional > 선택적 요청(Optional Requirement):
//NS nextstep의 약자
//프로토콜 프로퍼티, 프로토콜 메서드
//프로토콜 프로퍼티 -> 실질적인 구현부는 프로토콜과 동일하게 실질적인 구현은 안함 -> get set(읽기전용 Or 읽기쓰기? 역할에 대한 지정 가능) 적어줘야함
//프로토콜 프로퍼티: 연산 프로퍼티로 쓰든 저장 프로퍼티로 쓰든 상관하지 않는다! 명세하지 않기 때문에 프로퍼티를 저장 프로퍼티로 쓸 수 있고 연산 프로퍼티로 사용할 수 있다
//무조건 var로 선언해야 한다
//프로토콜에서 다른 프로토콜을 쓸 수 있는데 채택을 한다고 표현한다 (상속x)
//get set 지정은 최소 조건 -> 만약 get만 명시했다면 get 기능만 최소한 구현되어 있으면 된다 즉 필요하다면 set도 구현해도 된다
//딕셔너리 키는 중복 불가인데 hashable이라는 프로토콜을 채택해서
//collection -> array set dictionary collection과 sequence 프로토콜을 채택하고 있기 때문에 collection 타입이라 한다


@objc
protocol viewPresentableProtocol {
    
    var navigationTitleString: String {get set}
    var backgroundColor: UIColor { get }
    static var identifier: String { get }
    
    func configureView()
    @objc optional func configureLable()
    @objc optional func configureTextField()
}

/*
 ex. 테이블뷰
 */

@objc
protocol DanielTableViewProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
    @objc optional func didSelectRowAt()
}
