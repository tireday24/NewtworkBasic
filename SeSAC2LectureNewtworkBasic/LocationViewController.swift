//
//  LocationViewController.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {
    //정수값 리터럴이 적은게 좋은 코드
    //static var reuseIdentifier: String = String(describing: LocationViewController.self)
    
    //사용자가 아무것도 안누른 상태 not determine 상태
    //Notification 1.
    //알람 UN usernotification 클래스이기 때문에 인스턴스를 받아서 ios 정보를 가져옴
    //앱 키면 뱃지 제거
    //앱 킬때 push 된거 날리기 특정 시점 때 알림 없애주기
    //앱이 foreground에 있을 때 이미 앱을 쓰고 있기 때문에 Noti가 뜨면 안됨
    // foregruond 상태에서 Noti 받아야한다
    let notificationCenter = UNUserNotificationCenter.current()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Custom Font
//        for family in UIFont.familyNames {
//            print("=========\(family)==========")
            
            //세부 내용 출력 해봐라
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print(name)
//            }
//        }
        
        requestAuthorization()

      
    }
    
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        sendNotificaiton()
    }
    
    //Notification 2. 권한 요청
    //remove 앱 들어갔을 때 알람 리스트 삭제
    //요청할 때 얼럿 뱃지 사운드 권한을 요청한 옵션들 UNA -> 유저랑 상호작용 할 수 있는 구조체
    func requestAuthorization() {
        
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        //bool error 유저가 권한을 허용했냐 안했냐 에러 났을때 어떻게 할거냐
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            //함수안에 함수가 들어있는 상황 클래스가 가지고 있는 인스턴스를 호출해달라 그래서 self
            //알람 권한 보냄
            if success {
                self.sendNotificaiton()
            }
        }
    }
    //3. Notification 3. 권한 허용한 사용자에게 알림 요청(언제? 어떤 컨텐츠?)
    //iOS 시스템에서 알림을 담당 > 알림 등록 코드 필요
    /*
     - 권한 허용 해야만 알림이 온다
     - 권한 허용 문구 시스템적으로 최초 한번만 뜬다
     - 허용 안되어 있느 경우 애플 설정으로 직접 유도하는 코드를 구성 해야한다
     
     - 기본적으로 알림은 포그라운드에서 수신되지 않는다
     - 로컬 알림에서는 60초 이상 반복 가능 / 갯수 제한 64개 -> 기준 찾아보기 / 커스텀 사운드 30초
     
     
     1. 벳지 제거 > 언제 제거하는게 맞을까?  카톡 뱃지 제거 -> 챗방 들어갔을 시점 그 방에 해당하는 count만 빼는 구조
     2. 노티 제거 -> 노티의 유효 기간은? -> 카톡(오픈채팅,단톡) -> 언제 삭제해주는게 맞을까? -> 런치스크린에서 삭제하는 경우 , 벳지랑 똑같이 시스템을 가져가는 경우도 있음 -> 언제 삭제해주는게 맞을까?
     3. foreground에서의 noti 수신 -> 델리게이트 메서드로 해결
     
     +a
     - 쿠팡
     - 노티는 앱 실행이 기본인데, 특정 노티를 클릭할 때 특정 화면으로 가고 싶다면?
     - 포그라운드 수신 > 특정 화면에서는 안받고 특정 조건에 대해서만 프그라운드 수신을 하고 싶다면?
     - iOS15 집중모드 등 5~6 우선순위 존재!
     
     //ios 기본 정책 앱 사용시 알림 안보냄 default설정
     //앱을 종료한 시점을 개발자들이 모름 -> 타임인터벌 상대적으로 설정 불가능
     */
    
    func sendNotificaiton() {
        //컨텐츠 구성 클래스
        let notificationContents = UNMutableNotificationContent()
        
        notificationContents.title = "다마고치를 키워보세요"
        notificationContents.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...100))입니다"
        notificationContents.body = "저는 따끔따끔 다마고치입니다. 배고파요."
        //뱃지영역에 40뜸
        notificationContents.badge = 40
        
        //언제 보낼지 trigger
        //1. 시간 간격 2. 켈린더 3. 위치에 따라 설정 가능
        // 시간 간격은 60초 이상 설정해야 반복 가능
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        var dateComponents = DateComponents()
        //해당 분에 해당하는 반복
        dateComponents.minute = 15
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //알림 요청
        //identifier: 만약 알림 관리 할 필요 없다면 -> 알림 클릭하면 앱을 켜주는 정도
        //시간이 다르면 Identifier가 달라져서 쌓임
        //identifier가 특정 이름이라면 스택으로 쌓이지 않는다
        //만약 알림 관리 할 필요 O -> +1, 고유한 이름, 규칙
        //Date -> 날짜는 중복이 없으므로
        //알림 같은 종류 stack으로 쌓임
        //여러 종류
        // 다른 앱끼리는 저절로 구분 된다
        let request = UNNotificationRequest(identifier: "Daniel" , content: notificationContents, trigger: trigger)
        //"\(Date())" -> 스택 쌓임 알림 관리 필요없이 stack 쌓임
        notificationCenter.add(request)
        
        //에러 메세지도 띄워줄 수 있다
        //{ error in}
    }

}
