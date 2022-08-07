//
//  Constant.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/08/01.
//

import Foundation

//url 관리
struct APIKey {
    //전체 소문자 or 전체 대문자
    static let BOXOFFICE = "ee4645c90320403bec7e991490d2d13b"
    
    static let NAVER_ID = "Fv950ivdXLCglEG3G__f"
    static let NAVER_SECRET = "B9EwiNaMC2"
}

struct EndPoint {
    static let boxOfficeURL =  "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    static let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
}


//enum StoryboardName: String{
//    //문자열을 쓰기 싫다면 case를 대문자로
//    case Main
//    case Search
//    case Setting
//}

struct StroyboardName {
    
    //접근제어를 통해 초기화 방지
    // priviate 으로 인해 다른 파일에서는 쓰지 못하게 만들어줌
    // 이렇게 되면 열거형을 쓰나 구조체를 쓰나 상관이 없다
    // 하지만 private 마저 귀찮 공통적으로 쓰일때는 열거형을 쓰자!
    private init() {
        
    }
    
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

//열거형은 인스턴스를 만들지 못 한다

/*
 장점
 1. struct type property vs enum type property => 열거형에서 타입 프로퍼티 사용하면 뭐가 좋아?
 => 인스턴스 생성 방지 쓸 수 있지만 안쓰는 것 vs 아예 불가능
 인스턴스 생성시 문제가 뭘까?  -> 재사용이 목적인데 굳이 불필요한 공간을 차지하게 된다 코드의 일관성적인 형태가 흔들림
 2. enum case vs enum static => 중복, case 제약(double string)
 */

//enum StoryboardName {
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}

enum FontName {
    //case title = "SanFransisco"
    //같은 값을 가질 수 없다
    //case는 같은 글자를 표현할 수 없다
    //같은 값을 다른 변수에서 써야하는 상황 불가능
    //case body = "SanFransisco"
    //작은 글씨
    //case caption = "AppleSandol"
    
    //중복된 코드 하드코딩 가능
    static let title = "SanFransisco"
    static let body = "SanFransisco"
    static let caption = "AppleSandol"
}
