//
//  ViebController.swift
//  ZuYu2
//
//  Created by million on 2020/9/6.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import WebKit
import Toast_Swift

class WebController: UIViewController {
    
    var url : String!
    
    let backMethodName = "backItemClicked"
    
    init(_ url: String?) {
        super.init(nibName: nil, bundle: nil)
        self.url = url ?? ""
        if let token = getUser()?.accessToken {
            self.url = "\(self.url!)?token=\(token)"
        }
        print("url:\(self.url!)")
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
    
    lazy var contentView : UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        return contentView
    }()
    
    lazy var webView : WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.selectionGranularity = WKSelectionGranularity.character
        let userContent = WKUserContentController()
        userContent.add(self, name: backMethodName)
//        userContent.addUserScript(registerElementEvent(methodName: backMethodName, className: "van-nav-bar__left"))
        configuration.userContentController = userContent
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.allowsBackForwardNavigationGestures = true
        contentView.addSubview(webView)
        // 让webview翻动有回弹效果
        webView.scrollView.bounces = false
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        webView.load(request)
    }
    
    func callNative(code : String?, data: String?) {
        if let code = code, code == "back" {
            navigationController?.popViewController(animated: true)
        }
        if let code = code, code == "call", let phoneStr = data {
            let phone = "telprompt://" + phoneStr
            if UIApplication.shared.canOpenURL(URL(string: phone)!) {
                UIApplication.shared.open(URL(string: phone)!, options: [:], completionHandler: nil)
             }
        }
        if let code = code, code == "toast" {
            view.makeToast(data)
        }
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
        //webView.evaluateJavaScript("sayHello()", completionHandler: nil)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("webview error:\(error)")
    }
    
    ///接收js调用方法
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        if message.name == backMethodName {
            navigationController?.popViewController(animated: true)
        }
    }
    
    //! WKWeView在每次加载请求前会调用此方法来确认是否进行请求跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("navigation==>\(navigationAction.request.url!)")
        if let url = navigationAction.request.url, url.scheme == "protocol", url.host == "android" {
            let parameters = url.queryParameters
            let code = parameters?["code"]
            let data = parameters?["data"]
            callNative(code: code, data: data)
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
       
    }
//    - (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//
//        if ([navigationAction.request.URL.scheme caseInsensitiveCompare:@"jsToOc"] == NSOrderedSame) {
//            [WKWebViewInterceptController showAlertWithTitle:navigationAction.request.URL.host message:navigationAction.request.URL.query cancelHandler:nil];
//            decisionHandler(WKNavigationActionPolicyCancel);
//        }
//        else {
//            decisionHandler(WKNavigationActionPolicyAllow);
//        }
//    }
}
