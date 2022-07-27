//
//  0727 Daily.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/07/27.
//

import Foundation

struct ExchangeRate {
    var currencyRate: Double {
        willSet {
            print("환율 변동 예정: \(self.currencyRate) -> \(newValue)")
        }
        didSet {
            print("환율 변동 완료: \(oldValue) -> \(self.currencyRate)")
        }
        
    }
    
    var USD: Double {
        willSet {
            print("환전금액: USD:\(newValue)달러로 환전될 예정")
        }
        didSet {
            print("KRW: \(self.KRW) -> \(USD)달러로 환전되었음")
        }
    }
    
    var KRW: Double {
        get {
            return USD * currencyRate
        }
        set {
           USD = newValue / currencyRate
        }
    }
}

var rate = ExchangeRate(currencyRate: 1100, USD: 1)
rate.KRW = 500000
rate.currencyRate = 1350
rate.KRW = 500000
