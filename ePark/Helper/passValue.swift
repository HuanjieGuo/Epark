//
//  passValue.swift
//  ePark
//
//  Created by 郭焕杰 on 2017/8/27.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import Foundation

//工具类,放置一些经常用到的方法
//通过userDefault存储数据
class baseClass{
    
    func cacheSetString(key: String,value: String){
        let userInfo = UserDefaults()
        userInfo.setValue(value, forKey: key)
        print("成功赋值" + value)
    }
    
    func cacheGetString(key: String) -> String{
        let userInfo = UserDefaults()
        let tmpSign = userInfo.string(forKey: key)
        return tmpSign!
    }
    
    //读取字典数组
    func cacheSetDic(key:String,value: [Dictionary<String, Any>]){
        let userInformation = UserDefaults()
        userInformation.setValue(value, forKey: key)
        print("获取成功\n\n\(value)")
    }
    
    func cacheGetDic(key:String) -> [Dictionary<String, Any>] {
        let userInformation = UserDefaults()
        let tmp = userInformation.array(forKey: key)
        return tmp! as! [Dictionary<String, Any>]
    }
    //读取字典
    func cacheSetDicOnly(key:String,value: Dictionary<String, Any>){
        let userInformation = UserDefaults()
        userInformation.setValue(value, forKey: key)
        print("获取成功\n\n\(value)")
    }
    
    func cacheGetDicOnly(key:String) -> Dictionary<String, Any> {
        let userInformation = UserDefaults()
        let tmp = userInformation.dictionary(forKey: key)
        return tmp! as! Dictionary<String, Any>
    }
    //读取整数
    func cacheSetInt(key:String,value: Int){
        let userInformation = UserDefaults()
        userInformation.setValue(value, forKey: key)
        print("常数获取成功\(value)")
    }
    
    func cacheGetInt(key:String) -> Int {
        let userInformation = UserDefaults()
        let tmp = userInformation.integer(forKey: key)
        return tmp
    }

}

