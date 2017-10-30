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
        
         bookInformation = base1.cacheGetDic(key: "bookInfo")
        
        let cellNib = UINib(nibName:"BookCellTableViewCell",bundle:nil)
        bookTableView.register(cellNib, forCellReuseIdentifier: "bookCell")
        print("赋值成功：\n\(bookInformation[1])")
     
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
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
