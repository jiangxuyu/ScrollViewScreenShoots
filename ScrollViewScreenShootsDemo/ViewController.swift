//
//  ViewController.swift
//  ScrollViewScreenShootsDemo
//
//  Created by 骚姜的HHBoy on 2018/6/4.
//  Copyright © 2018年 骚姜的HHBoy. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class ViewController: UIViewController ,UIGestureRecognizerDelegate,WKUIDelegate,WKNavigationDelegate{

    lazy var webView =  WKWebView()
    var money:Float = 0.00;
    var password:NSString = ""
    var count:Int = 0;
    var currentCount:Int = 1;
    var currentMoney:Float = 0;
    let shotsBtn:UIButton = UIButton()
    let maxWithdrawMoney:Float = 50000.00
    
    var urlStr:NSString = "" {
        willSet {
            print("will set url")
        }
        didSet {
            print("did set url")
            //load webView
            webView.load(NSURLRequest(url: NSURL(string: self.urlStr as String)! as URL) as URLRequest)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setWebSubView()
        webView.uiDelegate = self
        webView.navigationDelegate = self;
        self.urlStr = "https://www.youku.com"
    }
    
    func setWebSubView() {
        webView.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        shotsBtn.setTitle("一键截图", for: UIControlState.normal)
//        shotsBtn.sizeToFit()
        shotsBtn.backgroundColor = UIColor.black
        self.view.addSubview(shotsBtn)
        shotsBtn.addTarget(self, action: #selector(scrollViewScreenShootsBtn), for: UIControlEvents.touchUpInside)
        shotsBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.bottom).offset(-85)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
//        shotsBtn.backgroundColor = UIColor.init(red: 228, green: 57, blue: 48, alpha: 1)
        
        shotsBtn.layer.masksToBounds = true
        shotsBtn.layer.cornerRadius = 40
    }

    
    @objc func scrollViewScreenShootsBtn() {
        UIScrollView.bd_scrollViewScreenshots(scrollView: self.webView.scrollView)
    }

    /// 页面开始加载
    @objc func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

        NSLog("loading start")
    }
    
    /// 页面加载完成
    @objc func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    /// 跳转失败的时候调用
    @objc func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
       
    }
    
    /// 内容加载失败
    @objc func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
       
    }
    
    @objc func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
}

