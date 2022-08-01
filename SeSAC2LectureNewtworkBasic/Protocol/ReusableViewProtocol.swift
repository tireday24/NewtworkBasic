//
//  ReusableViewProtocol.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/08/01.
//

import UIKit

protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}



extension UIViewController: ReusableViewProtocol {
    //확장이기 때문에 메모리 공간을 차지하는 저장프로퍼티는 사용하지 못한다
    static var reuseIdentifier: String { // 연산 프로퍼티일 때 get만 사용한다면 get 생략 가능 프로토콜을 채택한 모든 컨트롤러에서는 메타타입 가지고 있음
         String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    
}
