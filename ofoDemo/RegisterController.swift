//
//  RegisterController.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/10/12.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit
import APNumberPad
import SwiftHTTP
import FTIndicator
import SwiftyTimer
import SwiftyJSON

class RegisterController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var rigisterBtn: UIButton!
    
    @IBOutlet weak var sendSecurityCodeBtn: UIButton!
    @IBAction func backToMainVC(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func rigisterBtnTap(_ sender: Any) {
        if (userName.text == ""||passcode.text == ""){
            FTIndicator.showToastMessage("账号或密码为空，请重新输入！")
        }
        else if phone.text == ""||securityCode.text==""{
             FTIndicator.showToastMessage("手机或验证码为空，请重新输入！")
        }
        else {
            let params:[String : Any] = ["username":userName.text!,"password":passcode.text!,"phone":Int(phone.text!)!,"checkCode":Int(securityCode.text!)!]
            do{
                let opt = try HTTP.POST("http://139.196.72.74/api/v1/front/register",parameters: params)
                opt.start{respondse in
                    let result = JSON(respondse.data)["message"]
                    if respondse.statusCode == 200{
                        DispatchQueue.main.async {
                            
                        self.performSegue(withIdentifier: "registerSucceed", sender: self)
                        }
                    }
                    if respondse.statusCode == 403{
                        FTIndicator.showToastMessage(result.string)
                    }
   
                }
            }catch let error{
                  print("请求失败：\(error)")
            }
            
        }
        
    }
    @IBAction func sendSecurityCode(_ sender: Any) {
        
        
        self.alertLabel.isHidden = true
        if (userName.text == ""||passcode.text == ""){
            FTIndicator.showToastMessage("账号或密码为空，请重新输入！")
        }
        else {
            let params = ["phone":Int(phone.text!)]
            do{
              let opt = try HTTP.POST("http://139.196.72.74/api/v1/front/register/sms", parameters: params)
                opt.start{response in
                    print(response.description)
                   
                    let data = JSON(response.data)["message"]
                    if response.statusCode == 200
                    {
                        self.alertLabel.isHidden = false
                         var timeAll = 60
                        self.sendSecurityCodeBtn.isEnabled = false
                           DispatchQueue.main.async {
                        Timer.every(1, { (timer:Timer) in
                            timeAll = timeAll - 1
                            if timeAll == 0 {
                              
                                self.sendSecurityCodeBtn.isEnabled = true
                                self.alertLabel.isHidden = true
                                self.sendSecurityCodeBtn.setTitle("  获取验证码", for: .normal)
                                return
                                
                            
                            }
                            if timeAll>0 {
                             self.sendSecurityCodeBtn.setTitle("\(timeAll)秒后重试", for: .normal)
                                
                            }

                        })
                        }
                        
                    }
                    if response.statusCode == 403{
                       
                        self.alertLabel.text = data.string
                        self.alertLabel.textColor = UIColor.red
                        self.alertLabel.isHidden = false
                        print(response.description)
                    }
                    if response.statusCode == 500{
                      
                        self.alertLabel.text = data.string
                        self.alertLabel.textColor = UIColor.red
                          self.alertLabel.isHidden = false
                        print("验证   "+data.string!)
                    }
                }
            }catch let error{
                print("请求失败：\(error)")
            }
            
        
        }

    }
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var securityCode: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var passcode: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        sendSecurityCodeBtn.setTitle("  获取验证码", for: .normal)
        sendSecurityCodeBtn.isEnabled = false
        self.navigationItem.leftItemsSupplementBackButton = true
        phone.delegate = self
        alertLabel.isHidden = true

        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text
            else {
                return true
        }
        let newLength = text.characters.count + string.characters.count - range.length
        if newLength >= 11 {

              sendSecurityCodeBtn.isEnabled = true
        } else {

             sendSecurityCodeBtn.isEnabled = false
        }
        return newLength <= 11
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
