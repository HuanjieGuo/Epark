//
//  MyParkingInfoController.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/9/6.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit
import FTIndicator

class MyParkingInfoController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var tableView:UITableView?
    var token = ""
    var myParkPlace = [[String:Any]]()
    
    var baseInfo: baseClass = baseClass()
    var baseInfo2: baseClass = baseClass()
    
  



    override func viewDidLoad() {
        super.viewDidLoad()
        FTIndicator.showProgressWithmessage("Please waiting ...")
        self.title = "我的车位"
               self.myParkPlace = self.baseInfo.cacheGetDic(key: "info")
        self.baseInfo2.cacheSetDic(key: "info2", value: self.myParkPlace)
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView.startAnimating()

               
        self.tableView = UITableView(frame: self.view.bounds)

        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.allowsSelection = false
 

        self.tableView!.register(MyTableCell.self, forCellReuseIdentifier: "tableCell")
    
        self.view.addSubview(self.tableView!)
   
        

        // Do any additional setup after loading the view.
    }
    

    

    //分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //表格行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myParkPlace.count
    }
    
    //各个单元显示的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //创建一个重用单元格
     
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! MyTableCell
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute:
            {
                FTIndicator.dismissProgress()
        cell.textLabel?.text = self.myParkPlace[indexPath.row]["address"] as? String
        

        if self.myParkPlace[indexPath.row]["status"]! as! Int == 1{
            cell.switchT.setOn(true, animated: true)
        }
        else{
            cell.switchT.setOn(false, animated: true)
        }
        })
    
        return cell
   
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//
//
//    }
    

}

extension UITableViewCell {
    //返回cell所在的UITableView
    func superTableView() -> UITableView? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let tableView = view as? UITableView {
                return tableView
            }
        }
        return nil
    }
}



