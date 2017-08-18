//
//  ViewController.swift
//  Swift js 交互
//
//  Created by cfzq on 2017/8/15.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {

    fileprivate var _bridge:WebViewJavascriptBridge!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        HTTPCookie(properties: [NSHTTPCookieName: "wid",NSHTTPCookieValue: WID,NSHTTPCookieName: "www.google.com",NSHTTPCookieDomain: "",NSHTTPCookiePath: "","HttpOnly": ""])
        
        setUpJs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpJs() {
        let webView: UIWebView = UIWebView(frame: view.bounds)
        view.addSubview(webView)
        
        WebViewJavascriptBridge.enableLogging()
        
        _bridge =  WebViewJavascriptBridge.init(forWebView: webView)
        _bridge.setWebViewDelegate(self)
        
        _bridge.registerHandler("ljj_copyText") { (data, responseCallback) in
            print("回调成功")
        }
        
        _bridge.callHandler("ljj_getUserInfo", data: [ "userId":"123","userName":"张三" ])
        
        let path = Bundle.main.path(forResource: "ExampleApp", ofType:"html")
        let urlStr = URL.init(fileURLWithPath: path!)
        print(urlStr)
        webView.loadRequest(URLRequest(url:urlStr))
        
 
        
       
        callHandlerAction()
    }

    func callHandlerAction()  {
        
        _bridge.callHandler("ljj_getUserInfo", data: ["userId":"123","userName":"张三"]) { (response) in
            print("chenggong")
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
}

