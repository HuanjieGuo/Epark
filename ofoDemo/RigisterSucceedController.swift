//
//  RigisterSucceedController.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/10/14.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit

class RigisterSucceedController: UIViewController {

    @IBAction func `return`(_ sender: Any) {
        performSegue(withIdentifier: "returnToMain", sender: self)
    }
    @IBAction func returnToLogin(_ sender: Any) {
        performSegue(withIdentifier: "returnToMain", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
