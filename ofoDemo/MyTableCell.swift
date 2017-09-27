//
//  MyTableCellTableViewCell.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/9/6.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit
import SwiftHTTP
import FTIndicator

class MyTableCell: UITableViewCell {
    var switchT:UISwitch!
    var baseInfo2: baseClass = baseClass()
    var myParkPlace = [[String:Any]]()
    var base: baseClass = baseClass()
    var token = ""
    var sign:String = String()
    var button:UIButton!
    //初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //开关
        switchT = UISwitch(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
        switchT.addTarget(self, action: #selector(turnSwitch(_:)), for: UIControlEvents.valueChanged)
        
       
        
        self.addSubview(switchT)
    }
    

    //布局
    override func layoutSubviews() {
        super.layoutSubviews()
        switchT.center = CGPoint(x: bounds.size.width-35, y: bounds.midY)
    
    }
    
    
//    
//    //按钮点击事件响应
//    func tapped(_ button:UIButton) {
//        let tableView = superTableView()
//        let indexPath = tableView?.indexPath(for: self)
//        print("indexPath:\(indexPath!)")
//        
//    }
    var placeId:Int! = 10000
    
    
    
    func turnSwitch(_ switchT:UISwitch) {
        
        let tableView = superTableView()
        let indexPath = tableView?.indexPath(for: self)
        //indexPath!.row获取在第几行 。  第一行为0
        myParkPlace = baseInfo2.cacheGetDic(key: "info2")
        placeId = (myParkPlace[indexPath!.row]["id"] as! Int)
        self.sign = base.cacheGetString(key: "sign")
        token = self.sign
       
        
        if switchT.isOn {
            do{
                
                let opt = try HTTP.PUT("http://139.196.72.74/api/v1/front/user/place/open/\(placeId ?? 100)", headers: ["authorization":token])
                opt.start{response in

                     print(response.description)
                     if response.statusCode! < 400{
                        FTIndicator.setIndicatorStyle(.dark)
                        FTIndicator.showNotification(with: #imageLiteral(resourceName: "UnlockSucess"), title: "成功开启车位", message: "")
                     }else{
                        FTIndicator.setIndicatorStyle(.dark)
                        FTIndicator.showNotification(with: #imageLiteral(resourceName: "icon_slide_close"), title: "车位开启失败", message: "")
                    }
                }
                
            } catch let error{
                print("请求失败：\(error)")
                
            }


        }else{
    
            do{
                
                let opt = try HTTP.PUT("http://139.196.72.74/api/v1/front/user/place/close/\(placeId ?? 1000)", headers: ["authorization":token])
                opt.start{response in
 
                    if response.statusCode! < 400{
                        print(response.description)
                        FTIndicator.setIndicatorStyle(.dark)
                        FTIndicator.showNotification(with: #imageLiteral(resourceName: "UnlockSucess"), title: "成功关闭车位", message: "")
                    }else{
                        FTIndicator.setIndicatorStyle(.dark)
                        FTIndicator.showNotification(with: #imageLiteral(resourceName: "icon_slide_close"), title: "车位关闭失败", message: "")
                    }

                    print(response.description)
                }
           
            } catch let error{
                print("请求失败：\(error)")
                
            }

        }
  
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



}
