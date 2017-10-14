//
//  LoginController.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/8/21.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON
import SDCAlertView

class LoginController: UIViewController {
    
    
        var base: baseClass = baseClass()
    @IBAction func loginBtn(_ sender: UIButton) {
        checkUserInformation()
        
    }
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var userPasscodeField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var userName = ""
    var userPasscode = ""
    var token = ""
    var userNickname = ""
    var userID = ""
    var userPhoto = ""
    

    func checkUserInformation()  {
        if !userNameField.text!.isEmpty && !userPasscodeField.text!.isEmpty{
            userName = userNameField.text!
            userPasscode = userPasscodeField.text!
            
            //申请访问登陆
            let params = ["username":userName,"password":userPasscode]
            
            do{
                let opt = try HTTP.POST("http://139.196.72.74/api/v1/front/login", parameters: params)
                opt.start{response in
                    if response.statusCode! < 400{

                    print(" 获取到的数据：\(response.description)")
                        OperationQueue.main.addOperation {

                    let json = JSON(response.data)
                    self.token = json["token"].stringValue
                    self.userNickname = json["user"]["username"].stringValue
                    self.userID = json["user"]["id"].stringValue
                    self.userPhoto = json["user"]["photo"].stringValue
                    self.performSegue(withIdentifier: "login", sender: self)
                        }
                    }
                    else{
                        OperationQueue.main.addOperation {
                     
                        let json = JSON(response.data)
                        
                        
                        let alert = AlertController(title: "\(json["message"])", message: "", preferredStyle: .alert)
                        alert.add(AlertAction(title: "确定", style: .normal))
                        alert.present()

                    }
                    }
                    
                }
            } catch let error{
                print("请求失败：\(error)")
                
            }
            
            
            //test
            
            
            
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login"{
            
            let destVC = segue.destination as! revealViewController
            destVC.userID = userID
            destVC.token = token
            destVC.userPhoto = userPhoto
            destVC.userNickname = userNickname
           self.base.cacheSetString(key: "sign", value: token)

            print("loginToReveal" + token)
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}

