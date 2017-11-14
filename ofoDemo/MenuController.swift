//
//  MenuController.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/7/13.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftHTTP

class MenuController: UITableViewController {

    @IBAction func returnToLogin(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet weak var certImageView: UIImageView!
    @IBOutlet weak var certLabel: UILabel!
    @IBOutlet weak var myBookInfoCell: UITableViewCell!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!         //头像
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    var userID = ""
    var token = ""
    var userPhoto = ""
    var userNickname = ""
    var bookInformation = [[String:Any]]()
    var base1:baseClass = baseClass()
    

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.tableView?.deselectRow(at: indexPath, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func loadSource(_ sender:UITableViewCell) {
        do{
            let opt = try HTTP.GET("http://139.196.72.74/api/v1/front/order",headers: ["authorization":token])
            opt.start{response in
                if let err = response.error{
                    print("error:\(err.localizedDescription)")
                    return
                }
                if response.statusCode == 200{
                    self.bookInformation = JSON(response.data)["result"].arrayObject as! [[String : Any]]
                    self.base1.cacheSetDic(key: "bookInfo", value: self.bookInformation)

                    self.performSegue(withIdentifier: "myBookInfo", sender: self)
                    
                    
                    
                }
                if response.statusCode == 401{
                    print("token错误")
                }
            }


        }catch let error{
            print("请求失败:\(error)")
        }

        
//        performSegue(withIdentifier: "myBookInfo", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //为cell加动作
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(loadSource(_:)))
        myBookInfoCell.isUserInteractionEnabled = true
        myBookInfoCell.addGestureRecognizer(tapGR)
        
        if !token.isEmpty{
            nicknameLabel.text = userNickname
     
            let url = URL(string: userPhoto)
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data{
                let image = UIImage(data: imageData)
                avatar.image = image
                avatar.layer.masksToBounds = true
                avatar.layer.cornerRadius = avatar.bounds.width/2
                
            certImageView.image = #imageLiteral(resourceName: "KeyTification_homePage")
                certLabel.text = "已认证"
                certLabel.textColor = UIColor.yellow
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//
//
//
//    }
 

}
