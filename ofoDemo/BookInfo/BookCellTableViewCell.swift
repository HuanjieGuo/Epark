//
//  BookCellTableViewCell.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/10/25.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import UIKit

class BookCellTableViewCell: UITableViewCell {

    @IBOutlet weak var parkLocation: UILabel!

    @IBOutlet weak var parkMoney: UILabel!
    @IBOutlet weak var parkDuringTime: UILabel!

    @IBOutlet weak var bookBtn: UIButton!
    @IBAction func bookBtnTap(_ sender: Any) {
    }
    @IBOutlet weak var bookStatus: UILabel!
    @IBOutlet weak var startDate: UILabel!
   
    @IBOutlet weak var startTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
