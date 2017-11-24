//
//  ScanController.swift
//  ePark
//
//  Created by 郭焕杰 on 2017/8/2.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit
import swiftScan
import FTIndicator
class ScanController: LBXScanViewController {
    var isFlashOn = false
    var token = ""
    
    @IBOutlet weak var flashBtn: UIButton!
    @IBOutlet weak var panelView: UIView!
    @IBAction func flashBtnTap(_ sender: UIButton) {
        isFlashOn  = !isFlashOn
        scanObj?.changeTorch()
        
        if isFlashOn {
           flashBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch"), for: .normal)
        } else {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_unenableTorch_w"), for: .normal)
        }
    }

    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        if let result = arrayResult.first{
            let msg = result.strScanned
            
            FTIndicator.setIndicatorStyle(.dark)
            FTIndicator.showToastMessage(msg)
          
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "扫码停车"
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.tintColor = UIColor.white
        
        var style = LBXScanViewStyle()
        style.anmiationStyle = .NetGrid
        style.animationImage = UIImage(named:"CodeScan.bundle/qrcode_scan_part_net")
        
        scanStyle = style
        
        print("验证 扫码"+token+"test")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.bringSubview(toFront: panelView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor=UIColor.black
        //在input页返回显示为空
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
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
