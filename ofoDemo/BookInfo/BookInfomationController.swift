//
//  BookInfomationController.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/10/25.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit

class BookInfomationController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet weak var allBookBtn: MyProviewButton!
    
    @IBAction func finishBookBtnTap(_ sender: Any) {
        finishBookBtn.borderColor = .orange
        finishBookBtn.setTitleColor(.orange, for: .normal)
        unfinishBookBtn.borderColor = .gray
        unfinishBookBtn.setTitleColor(.gray, for: .normal)
        allBookBtn.borderColor = UIColor.gray
        allBookBtn.setTitleColor(UIColor.gray, for: .normal)
    }
    @IBOutlet weak var finishBookBtn: MyProviewButton!
    @IBAction func unfinishBookBtnTap(_ sender: Any) {
        unfinishBookBtn.borderColor = .orange
        unfinishBookBtn.setTitleColor(.orange, for: .normal)
        allBookBtn.borderColor = UIColor.gray
        allBookBtn.setTitleColor(UIColor.gray, for: .normal)
        finishBookBtn.borderColor = .gray
        finishBookBtn.setTitleColor(.gray, for: .normal)
    }
    @IBOutlet weak var unfinishBookBtn: MyProviewButton!
    @IBAction func allBookBtnTap(_ sender: Any) {
        allBookBtn.borderColor = UIColor.orange
        allBookBtn.setTitleColor(UIColor.orange, for: .normal)
        unfinishBookBtn.borderColor = .gray
        unfinishBookBtn.setTitleColor(.gray, for: .normal)
        finishBookBtn.borderColor = .gray
        finishBookBtn.setTitleColor(.gray, for: .normal)
        
    }
    @IBOutlet weak var bookTableView: UITableView!
    
    var bookInformation = [[String:Any]]()
    var base1:baseClass = baseClass()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的订单"
        bookTableView.delegate = self
        bookTableView.dataSource = self
        bookTableView.separatorStyle = .singleLine
        bookTableView.allowsSelection = true
        
        allBookBtn.borderColor = UIColor.orange
        allBookBtn.setTitleColor(UIColor.orange, for: .normal)
        
        
         bookInformation = base1.cacheGetDic(key: "bookInfo")
        
        let cellNib = UINib(nibName:"BookCellTableViewCell",bundle:nil)
        bookTableView.register(cellNib, forCellReuseIdentifier: "bookCell")
        
        
        
        
        
     
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BookCellTableViewCell = self.bookTableView.dequeueReusableCell(withIdentifier: "bookCell") as! BookCellTableViewCell
        let nowBookInformation = bookInformation[indexPath.row]
        
        //time
        let startTime = nowBookInformation["start_time"]
        let startTime_Date_Year = (startTime as! NSString).substring(to: 4)
        let startTime_Date_Month = (startTime as! NSString).substring(with: NSMakeRange(5, 2))
        let startTime_Date_Day = (startTime as! NSString).substring(with: NSMakeRange(8, 2))
        let startTime_Time = (startTime as! NSString).substring(with: NSMakeRange(11, 5))
        print("\n"+startTime_Date_Year+" "+startTime_Date_Month+" "+startTime_Date_Day+" "+startTime_Time)
        cell.startTime.text = startTime_Time
        cell.startDate.text = startTime_Date_Month+"月"+startTime_Date_Day+"日"
        
        //status and button setting
        cell.bookStatus.text = nowBookInformation["status_name"] as? String
        switch nowBookInformation["status_name"] as? String {
        case "待付费"?:
            cell.bookStatus.textColor = .red
            cell.bookBtn.borderColor = .green
            cell.bookBtn.setTitle("支付", for: .normal)
            cell.bookBtn.setTitleColor(.green, for: .normal)
            
            
        case "已创建"?:
            cell.bookStatus.textColor = UIColor.darkGray
            cell.bookBtn.setTitle("结束停车", for: .normal)
            cell.bookBtn.borderColor = .orange
            cell.bookBtn.setTitleColor(.orange, for: .normal)
        default:
            cell.bookStatus.textColor = .black
        }
        
        //price
        cell.parkMoney.text = nowBookInformation["price"] as? String
        
        //location
        
        let region_name:String = (nowBookInformation["region_name"] as? String)!
        let place_name:String = (nowBookInformation["place_name"] as? String)!
        cell.parkLocation.text = region_name+place_name
        
        //until time
        let timeUnit = nowBookInformation["timeunit"] as? Double
        

        
         if(timeUnit == nil){
            cell.parkDuringTime.text = "None"
        }
        else{
            let parkTime = timeUnit!
                   cell.parkDuringTime.text = String(Int(parkTime/1))+"小时"+String(Int((parkTime-Double(Int(parkTime/1)))*60)+1)+"分钟"
        }
        
        
        
        
        
        
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bookTableView.deselectRow(at: indexPath, animated: true)
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
