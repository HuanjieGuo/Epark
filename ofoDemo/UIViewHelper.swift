//
//  UIViewHelper.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/8/5.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

//extension UIView{
//    @IBInspectable var borderWidth: CGFloat {
//        get {
//            return self.layer.borderWidth
//        }
//        set {
//            self.layer.borderWidth = newValue
//        }
//    }
//    
//    @IBInspectable var borderColor: UIColor {
//        get {
//            return UIColor(cgColor:self.layer.borderColor!)
//        }
//        set {
//            self.layer.borderColor = newValue.cgColor
//        }
//    }
//    @IBInspectable var cornorRadius: CGFloat {
//        get {
//            return self.layer.cornerRadius
//        }
//        set {
//            self.layer.cornerRadius = newValue
//            self.layer.masksToBounds = newValue > 0
//        }
//    }
//    
//}


//@IBDesignable class MyProviewLable: UILabel {
//    
//}
//
//@IBDesignable class MyProviewText: UITextField {
//    
//}
//@IBDesignable class MyProviewButton: UIButton {
//    
//}
//@IBDesignable class MyProviewContainer: UIView {
//    
//}
//@IBDesignable class MyProviewCell: UITableViewCell {
//    
//}



import AVFoundation
func turnTorch() {
    guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)else{return}
    if device.hasTorch  && device.isTorchAvailable{
        try? device.lockForConfiguration()
        if device.torchMode == .off{
            device.torchMode = .on
        }else{
            device.torchMode = .off
        }
        
        device.unlockForConfiguration()
    }
}





