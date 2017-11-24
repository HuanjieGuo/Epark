//
//  unLockController.swift
//  ePark
//
//  Created by 郭焕杰 on 2017/8/6.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//
import SwiftySound
import UIKit
import SwiftHTTP
import SwiftyJSON




class UnlockController: UIViewController {
     
    var defaults = UserDefaults.standard
    var isVoiceOn = true
    var isTorchOn = false
    var number = ""
    var location = ""
    var money = ""

    var token = ""
    var parkOrderId:Int = Int()

    
    var base: baseClass = baseClass()
    var sign:String = String()
//    

    
    @IBOutlet weak var parkLocationLabel: UILabel!
    @IBOutlet weak var parkNumberLabel: UILabel!

    @IBOutlet weak var parkMoneyLabel: UILabel!


    @IBOutlet weak var voiceBtn: UIButton!
    @IBOutlet weak var flashBtn: UIButton!
    @IBAction func voiceBtnTap(_ sender: UIButton) {
        isVoiceOn = !isVoiceOn
        
        if isVoiceOn {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
            defaults.set(true, forKey: "isVoiceOn")
        } else {
            voiceBtn.setImage(#imageLiteral(resourceName: "voice_close"), for: .normal)
            defaults.set(false, forKey: "isVoiceOn")
        }


    }
    @IBAction func flashBtnTap(_ sender: UIButton) {
        turnTorch()
        if isTorchOn{
            flashBtn.setImage(#imageLiteral(resourceName: "btn_unenableTorch_w"), for: .normal)
        } else {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch"), for: .normal)
        }
        isTorchOn = !isTorchOn
    }
    @IBAction func unlockBtn(_ sender: UIButton) {
        
   
        
    
        if defaults.bool(forKey: "isVoiceOn"){
            Sound.play(file: "已开锁.mp3")
            
        }
      
    }
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.sign = base.cacheGetString(key: "sign")
        token = self.sign
        print("开锁页成功" + token)
   
        
        if defaults.bool(forKey: "isVoiceOn"){
            Sound.play(file: "按开锁按钮进行停车.mp3")
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)

        } else {
            voiceBtn.setImage(#imageLiteral(resourceName: "voice_close"), for: .normal)

        }
        
        parkNumberLabel.text = number
        parkMoneyLabel.text = money + " 元／时"
        parkLocationLabel.text = location
 
       
    

     
        

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "unlock"{
            let destVC = segue.destination as! PakingController
            destVC.number = self.number
            destVC.money = self.money
            destVC.location = self.location
            destVC.token = self.token
            
         
            
            
            
        //开锁网络访问
            let params = ["place_id":number]
            
            do{

                let opt = try HTTP.POST("http://139.196.72.74/api/v1/front/order", parameters: params,headers: ["authorization":self.token])
                opt.start{response in
                    let json = JSON(response.data)
                    self.parkOrderId = json["result"][0]["id"].intValue
                    destVC.parkOrderId = self.parkOrderId
                     print("成功联网， 订单号码数据：\(self.parkOrderId)")
                    print("成功联网， 获取到的数据：\(response.description)")
                }
            } catch let error{
                print("请求失败：\(error)")
                
            }
            

        }
    }
 

}

