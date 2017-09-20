//
//  ErrorViewController.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/8/14.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit
import MIBlurPopup
class ErrorViewController: UIViewController {
    @IBAction func gestureTap(_ sender: UITapGestureRecognizer) {
        self.close()
    }

    @IBAction func closeBtn(_ sender: Any) {
        close()
    }
    @IBOutlet weak var myPopupView: UIView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close()  {
         dismiss(animated: true)
    }

}

extension ErrorViewController:MIBlurPopupDelegate{
    var popupView:UIView{
        return myPopupView
    }
    var blurEffectStyle:UIBlurEffectStyle{
        return .dark
    }
    var initialScaleAmmount:CGFloat{
        return 0.2
    }
    var animationDuration: TimeInterval{
        return 0.2
    }
}
