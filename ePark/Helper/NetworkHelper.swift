//
//  NetworkHelper.swift
//  ePark
//
//  Created by 郭焕杰 on 2017/8/8.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//

import AVOSCloud

struct NetworkHelper {
    
}

extension NetworkHelper{
    static func getLocation(code: String,completion:@escaping (String?) -> Void ){
        let query =  AVQuery(className: "parkInformation")
        
        query.whereKey("parkNumber", equalTo: code)

        query.getFirstObjectInBackground { (code,e) in
            
                if let e = e{
                    print("出错",e.localizedDescription)
                    completion(nil)
                }
            if let code = code,let location = code["parkLocation"] as? String {
                    completion(location)
            }
            }
    }
    
    
    static func getObjectID(code: String,completion:@escaping (String?) -> Void ){
        let query =  AVQuery(className: "parkInformation")
        
        query.whereKey("parkNumber", equalTo: code)
        
        query.getFirstObjectInBackground { (code,e) in
            
            if let e = e{
                print("出错",e.localizedDescription)
                completion(nil)
            }
            if let code = code,let objectID = code["objectId"] as? String {
                completion(objectID)
            }
        }
    }

    
    
    static func getMoney(code: String,completion:@escaping (String?) -> Void ){
        let query =  AVQuery(className: "parkInformation")
        
        query.whereKey("parkNumber", equalTo: code)
        query.getFirstObjectInBackground { (code,e) in
            
            if let e = e{
                print("出错",e.localizedDescription)
                completion(nil)
            }
            if let code = code,let money = code["parkMoney"] as? String {
                completion(money)
            }
        }
    }
    
    static func changeTo1(objectId:String)  {
        let todo = AVObject(className: "parkInformation", objectId: objectId)
        todo["parkStatus"] = "1"
        todo.save()
    }


}
