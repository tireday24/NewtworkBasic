//
//  UserDefaultsHelper.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/08/01.
//

import UIKit

//userdefault 키를 구조체나 열거형에 정리

class UserDefaultsHelper {
    
    private init() {}
    //다른 파일에서 초기화 방지
    
    //이 인스턴스만 재활용되는 형태로 만들어보겠다
    //왜 스탠다드? 타입프로퍼티로 제한을 하면서 한군데에서만 사용 가능하도록 함
    //struct로 바꾸면 singleton pattern이라고 하기에 애매하다
    static let standard = UserDefaultsHelper()
    //singleton pattern 자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음
    //주의점 다른 파일에서 UserDefaultshelper 인스턴스를 만들면 규칙이 깨짐
    //열거형은 빌드전에 메모리에 올라가 있어야함 compile type 전역변수 저장하는 곳에 저장된다 한군데에 저장되어 있고 가져다 쓰는 형태
    //싱글톤 객체 자체는 static이지만, 객체 안의 저장 프로퍼티들은 싱글톤 객체를 쓸 때만 메모리에 올라온다는 말이다
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case nickname
        case age
    }
    
    var nickname: String {
        get {
            
            UIApplication.shared
            FileManager.default //데이터에 대한 동기화 관점을 활용하기 위해서 singleton Pattern 활용

            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {//연산 프로퍼티 parameter
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue) //bool도 기본값이 있다 integer는 기본값이 0
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
    
}

/*
 iOS 개발에서 중요한점
 화면 잘만들기
 네트워크 통신
 데이터베이스
 */

