//
//  revealViewController.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/8/22.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit
import SWRevealViewController

class revealViewController: SWRevealViewController {

    
    var userID = ""
    var token = ""
    var userPhoto = ""
    var userNickname = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.performSegue(withIdentifier: "sw_front", sender: self)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sw_rear"{
            
//            let destVC = segue.destination as! MenuController
//            destVC.userID = userID
//            destVC.token = token
//            destVC.userPhoto = userPhoto
//            destVC.userNickname = userNickname
//            
        }

        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
