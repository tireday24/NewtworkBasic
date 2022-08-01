//
//  WebViewController.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    //string describing -> 문자열 변환 -> 어떤 형태로 쓰임? 메타타입 -> "WebViewController" = String(describing: WebViewController.self)
    //static var reuseIdentifier: String = String(describing: WebViewController.self)
    
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
        

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButton))
        let image = UIImage(systemName: "chevron.backward")
        let leftButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIImageView(image: image))
        
    }

    @objc func backButton() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: buttonViewController.identifier) as! buttonViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
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
    
    @IBAction func stopButtonClicked(_ sender: UIBarButtonItem) {
        webView.stopLoading()
    }
    

    @IBAction func goBackButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    
    @IBAction func reloadButtonClicked(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func goFowardButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.canGoForward
        }
    }
    
    
}

extension WebViewController: UISearchBarDelegate {
    //enter 눌렀을때, http일때는 안나오는 사이트가 태반
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            print("Invaild URL")
            return
        }
        openWebPage(url: text)
        // 옵셔널 바인딩 처리
    }
}
