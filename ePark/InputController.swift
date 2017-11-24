//
//  InputController.swift
//  ePark
//
//  Created by 郭焕杰 on 2017/8/5.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit
import APNumberPad
import SwiftySound
class InputController: UIViewController,APNumberPadDelegate,UITextFieldDelegate {
    var isFlashOn = false
    var isVoiceOn = true
    var token = ""
    var defaults = UserDefaults.standard
 
    
    @IBAction func goBtnTap(_ sender: UIButton) {
        checkPass()
    }
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var goBtn: UIButton!

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
        isFlashOn = !isFlashOn
        if isFlashOn {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch"), for: .normal)
        } else {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_unenableTorch_w"), for: .normal)
        }
    }
    @IBOutlet weak var voiceBtn: UIButton!
    @IBOutlet weak var flashBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("输入页 +  token" + token)
        title = "车位解锁"
        print("车位信息显示\(parkInformation)")
        
//        inputTextField.layer.borderWidth = 2
//        inputTextField.layer.borderColor = UIColor.ofo.cgColor
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "扫码用车", style: .plain, target: self, action: #selector(backToScan))
        
        let numberPad = APNumberPad(delegate: self)
        numberPad.leftFunctionButton.setTitle("确定", for: .normal)
        inputTextField.inputView = numberPad
        inputTextField.delegate = self
        
        goBtn.isEnabled = false
        
        if defaults.bool(forKey: "isVoiceOn"){
              Sound.play(file: "请输入车位号.mp3")
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
        } else {
            voiceBtn.setImage(#imageLiteral(resourceName: "voice_close"), for: .normal)
        }
      
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text
            else {
            return true
        }
        let newLength = text.characters.count + string.characters.count - range.length
        if newLength>0 {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_enable"), for: .normal)
            goBtn.backgroundColor = UIColor.ofo
            goBtn.isEnabled = true
        } else {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_unenable"), for: .normal)
            goBtn.backgroundColor = UIColor.groupTableViewBackground
            goBtn.isEnabled = false
        }
        return newLength <= 8
    }
    
    func numberPad(_ numberPad: APNumberPad, functionButtonAction functionButton: UIButton, textInput: UIResponder) {
        checkPass()
    
    }

    func backToScan() {
        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var location = ""
    var money = ""
    var number = ""
    var objectId = ""
    var parkInformation = [[String:Any]]()
    
    

    

    func checkPass()  {
        if !inputTextField.text!.isEmpty{
            let code = inputTextField.text!
         print("车位数量\(parkInformation.count-1)")
            for i in 0...(parkInformation.count-1){
               
//                print(parkInformation[i]["id"] as! Int)
            
                if code == String(parkInformation[i]["id"] as! Int){
                    number = code
                    location = (parkInformation[i]["address"] as! String)+"("+(parkInformation[i]["name"] as! String)+")"
                    money = String(parkInformation[i]["price"] as! Int)
                    self.performSegue(withIdentifier: "showInformation", sender: self)
                    break
                }
                
                else{
                    if i == parkInformation.count-1{
                        self.performSegue(withIdentifier: "showErrorView", sender: self)
                    }
                }
            }
            
        
            
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInformation"{
          let destVC = segue.destination as! UnlockController
            destVC.number = self.number
            destVC.money  = self.money
            destVC.location = self.location
          
        }
    }
}

    


