//
//  BookInfomationController.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/10/25.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit

class BookInfomationController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell()
        print(indexPath)
        return cell
    }
    
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
        bookTableView.separatorStyle = .none
        
         bookInformation = base1.cacheGetDic(key: "bookInfo")
     
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
