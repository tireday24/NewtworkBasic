//
//  BeerInfo.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/08/01.
//

import UIKit

struct Beer {
    var name: String
    var imageURL: String
    var description: String
}

struct BeerInfo {
    var info: [Beer] = [
        Beer(name: "테라", imageURL: "https://img1.daumcdn.net/thumb/R1280x0/?fname=http://t1.daumcdn.net/brunch/service/user/3hwo/image/bJxy1vFSObiL-8AlB5DEPBlrPGc.png", description: "테라"),
        Beer(name: "카스", imageURL: "http://taxtimes.co.kr/data/photos/mig_photos/2017/228756/228756_2.jpg", description: "카스"),
        Beer(name: "곰표", imageURL: "https://file.mk.co.kr/meet/neds/2021/05/image_readtop_2021_457343_16207977624642501.jpg", description: "곰표"),
        Beer(name: "말표", imageURL: "https://cdn.emetro.co.kr/data2/content/image/2020/10/13/.cache/512/20201013500226.jpg", description: "말표"),
        Beer(name: "백양", imageURL: "https://img.seoul.co.kr/img/upload/2021/06/15/SSI_20210615182137_O2.jpg", description: "백양")
        
    ]
}
