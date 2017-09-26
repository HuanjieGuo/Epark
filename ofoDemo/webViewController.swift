//
//  webViewController.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/6/16.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//UITabBarController

import UIKit
import WebKit

class webViewController: UIViewController  {

    var webView:WKWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: self.view.frame)
        view.addSubview(webView)
        
        self.title = "汽车资讯"
        let url =  URL(string:"http://www.autohome.com.cn/shanghai/")!
        let request = URLRequest(url: url)
       webView.load(request)

        // ERROR /BuildRoot/Library/Caches/com.apple.xbs/Sources/VectorKit_Sim/VectorKit-1230.34.9.30.27/GeoGL/GeoGL/GLCoreContext.cpp 1763: InfoLog SolidRibbonShader:
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
