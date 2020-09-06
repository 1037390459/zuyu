//
//  ViebController.swift
//  ZuYu2
//
//  Created by million on 2020/9/6.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class WebController: UIViewController {
    
    var url : String!
    
    let backMethodName = "backItemClicked"
    
    init(_ url: String?) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerElementEvent(methodName : String, id : String) -> WKUserScript {
        let source = "function fun(){window.webkit.messageHandlers.\(methodName).postMessage(null);}(function(){var btn=document.getElementById(\"\(id)\");btn.addEventListener('click',fun,false);}());"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        return script
    }
    
    func registerElementEvent(methodName : String, className : String) -> WKUserScript {
        let source = "function fun(){window.webkit.messageHandlers.\(methodName).postMessage(null);}(function(){var btn=document.getElementsByClassName(\"\(className)\")[0];btn.addEventListener('click',fun,false);}());"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        return script
    }
    
    lazy var webView : WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.selectionGranularity = WKSelectionGranularity.character
        let userContent = WKUserContentController()
        userContent.add(self, name: backMethodName)
        userContent.addUserScript(registerElementEvent(methodName: backMethodName, className: "van-nav-bar__left"))
        configuration.userContentController = userContent
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
        view.addSubview(webView)
        // 让webview翻动有回弹效果
        webView.scrollView.bounces = false
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeb()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func loadWeb() {
        guard let request = URLRequest(urlString: url) else {
            return
        }
        SVProgressHUD.show()
        webView.load(request)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension WebController: WKNavigationDelegate, WKScriptMessageHandler {
    
    ///在网页加载完成时调用js方法
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish load")
        SVProgressHUD.dismiss()
        //webView.evaluateJavaScript("sayHello()", completionHandler: nil)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    ///接收js调用方法
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        if message.name == backMethodName {
            navigationController?.popViewController(animated: true)
        }
    }
}
