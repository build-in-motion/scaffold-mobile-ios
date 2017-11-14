//
//  WebViewController.swift
//  Wrapper
//
//  Created by Stephen Bechtold on 12/20/16.
//  Copyright © 2016 Build in Motion. All rights reserved.
//

import UIKit
import InMotion
import InMotionUI

class WebViewController: InMotionViewController, UIWebViewDelegate, ContextDelegate {

    
    @IBOutlet weak var webView:UIWebView!;
    var uri:URL!;
    let refreshControl = UIRefreshControl();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.webView.backgroundColor = UIColor.gray;
        self.navigationController?.isNavigationBarHidden = true;
        self.refreshControl.addTarget(self, action: #selector(WebViewController.refreshPage), for: .valueChanged);
        self.webView.scrollView.addSubview(self.refreshControl);
        
        Context.current.addResponder(self, error: nil);
        self.loadRequest();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        Context.current.removeResponder(self, error: nil);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadRequest() {
        self.uri = (self.uri != nil) ? self.uri :URL(string: AppConfig.current.custom?.getValue("rootUri") ?? "https://admin.inmotionapptest.net")!;
    
        if (Context.current.auth?.token != nil || !AppConfig.current.requiresLogin) {
            if (Context.current.auth?.token != nil) {
                self.uri = URL(string: String(format:"?isWebView&token=%@", Context.current.auth?.token?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "unknown"), relativeTo: self.uri);
                
                let jar = HTTPCookieStorage.shared;
                let cookieHeaderField = ["Set-Cookie": String(format:"token=%@", Context.current.auth?.token ?? "undefined")];
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: cookieHeaderField, for: self.uri)
                jar.setCookies(cookies, for: self.uri, mainDocumentURL: self.uri);
            }
            let request = URLRequest(url: self.uri);
            self.webView.loadRequest(request);
        }
        else if (AppConfig.current.requiresLogin) {
            let loginViewController = LoginViewController(nibName: "LoginView", bundle: nil);
            self.present(loginViewController, animated: true, completion: nil);
        }
    }
    
    @objc func refreshPage() {
        self.webView.reload();
    }
    
    // MARK: - UIWebViewDelegate Members
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.isBusy = true;
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.isBusy = false;
        self.refreshControl.endRefreshing();
    }
    
    // MARK: - ContextDelegate Members
    func context(_ session: Context, didUpdateAuthorization authorization: Authorization) {
        self.loadRequest();
    }

}
