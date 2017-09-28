//
//  PakingController.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/8/6.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit
import SwiftyTimer
import SDCAlertView
import SwiftHTTP
import FTIndicator





class PakingController: UIViewController {
    var number = ""
    var money = ""
    var location = ""
    var token = ""
    var parkOrderId:Int = Int()
    var pakingSecond = 0
    var pakingMoneyNow = 0.00
    @IBOutlet weak var parkLocationLabel: UILabel!
    @IBOutlet weak var parkNumberLabel: UILabel!

    @IBOutlet weak var everyHourMoney: UILabel!
    @IBOutlet weak var pakingTime: UILabel!
    @IBOutlet weak var pakingMoney: UILabel!
    
    @IBAction func problemBtn(_ sender: Any) {
        unlockError()
        let alert = AlertController(title: "显示密码", message: "密码已在车锁上显示，请查看", preferredStyle: .alert)
        alert.add(AlertAction(title: "确定", style: .normal))
        alert.present()

    }
    
    
    func unlockError()  {
        
        do{
            
            let opt = try HTTP.GET("http://139.196.72.74/api/v1/front/order/password/\(parkOrderId)", headers: ["authorization":self.token])
            opt.start{response in
                
                print("已显示密码：\(response.description)")
            }
        } catch let error{
            print("请求失败：\(error)")
            
        }

    }
    func seuge()  {

        endParkHTTP()
        self.navigationController?.popToRootViewController(animated: true);

//        self.performSegue(withIdentifier: "finishPay", sender: self)
        
    }
    
    func endParkHTTP() {
        
        do{
            
            let opt = try HTTP.PUT("http://139.196.72.74/api/v1/front/order/finish/\(parkOrderId)", headers: ["authorization":self.token])
            opt.start{response in
                
                print("成功联网， 获取到的数据：\(response.description)")
            }
        } catch let error{
            print("请求失败：\(error)")
            
        }

    }

    @IBAction func endParkingTap(_ sender: Any) {
        let alert = AlertController(title: "结束停车", message: "本次停车费\(String(format:"%.2f",self.pakingMoneyNow))元将自动从我的钱包里面扣除，请先将车移开车位后按确认支付，结束本次停车", preferredStyle: .alert)
        alert.add(AlertAction(title: "继续停车", style: .normal))
        alert.add(AlertAction(title: "确认支付", style: .preferred, handler: { (turnBtn) in

        self.seuge()
            FTIndicator.setIndicatorStyle(.light)
            
            FTIndicator.showNotification(with: #imageLiteral(resourceName: "UnlockSucess"), title: "成功支付", message: "已成功从您的钱包里扣除本次停车费\(String(format:"%.2f",self.pakingMoneyNow))元")
            
            
        }))
        alert.present()


        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //隐藏返回
        self.navigationItem.setHidesBackButton(true, animated: true)

//        NetworkHelper.changeTo1(objectId: objectId)
//        print("验证" + objectId)
        
        parkNumberLabel.text = number
        parkLocationLabel.text = location
        everyHourMoney.text = money + " 元／时"
        Timer.every(1) { (timer:Timer) in
            self.pakingSecond += 1
            self.pakingTime.text = self.timeFormatted(totalSeconds: self.pakingSecond)
        }
        
        Timer.every(30) { (timer:Timer) in
                    
                    self.pakingMoneyNow += Double(self.money)!/3600*30
                    self.pakingMoney.text = String(format:"%.2f",self.pakingMoneyNow) + "元"
        }

    
     

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    

}
