//
//  ContainerViewController.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/9/27.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var parkMoney: UILabel!
    @IBOutlet weak var parkName: UILabel!
    @IBOutlet weak var parkAddress: UILabel!
    @IBOutlet weak var parkNumber: UILabel!
    @IBOutlet weak var parkStatus: UILabel!
    var baseInfo3:baseClass = baseClass()
    var parkPlace = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        parkPlace = baseInfo3.cacheGetDicOnly(key: "park")
        parkNumber.text = String(parkPlace["id"] as! Int)
        parkName.text = parkPlace["name"] as? String
        parkAddress.text = parkPlace["address"] as? String
        parkMoney.text = String(parkPlace["price"] as! Int) + " 元／时"
        parkStatus.text = parkPlace["status_name"] as? String

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
