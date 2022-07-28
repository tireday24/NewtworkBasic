//
//  WebViewController.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    var destinationURL: String = "https://www.apple.com"
    //App Transport Scurity settings -> http 거의 다 막음
    //왜 거의 다? Http -> https로 바꾸는 회사도 있다
    //설정이 필요하다
    //ui 만들기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        openWebPage(url: destinationURL)
    
    }
    
    func openWebPage(url: String) {
        //유효한 URL인지 확인
        guard let url = URL(string: url) else {
            print("Invaild URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
        //skeletonView library
    }


}

extension WebViewController: UISearchBarDelegate {
    //enter 눌렀을때, http일때는 안나오는 사이트가 태반
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(url: searchBar.text!)
        // 옵셔널 바인딩 처리
    }
}
