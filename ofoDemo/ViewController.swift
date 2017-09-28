//
//  ViewController.swift
//  ofoDemo
//
//  Created by 郭焕杰 on 2017/6/16.
//  Copyright © 2017年 hjackguo.github.io. All rights reserved.
//UIViewController
import UIKit
import SWRevealViewController
import SwiftHTTP
import SwiftyJSON
import FTIndicator

class ViewController: UIViewController,MAMapViewDelegate,AMapSearchDelegate,AMapNaviWalkManagerDelegate {
    var mapView:MAMapView!
    var search:AMapSearchAPI!
    var pin : MyPinAnnotation!
    var pinView:MAAnnotationView!
    var nearBySearch = false
    var start,end : CLLocationCoordinate2D!
    var walkManager : AMapNaviWalkManager!
    var parkInformation = [[String:Any]]()
    var tag = Int()
    var testLatitude:Double = Double()
    var token = ""
    var base: baseClass = baseClass()
     var manyAnnotation : [MAPointAnnotation] = []
    var sign:String = String()
    var baseInfo: baseClass = baseClass()
    var baseInfo2: baseClass = baseClass()
   

    @IBOutlet weak var panelView: UIView!
    @IBAction func locationTap(_ sender: Any) {
        clikLocation()
    }
    
    func clikLocation() {
        
        //        self.pin.isLockedToScreen = true
        //        self.pin.lockedScreenPoint = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        
        self.pin.lockedScreenPoint = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        //        self.pin.isLockedToScreen = true
        self.pin.coordinate.latitude = self.mapView.userLocation.coordinate.latitude
        self.pin.coordinate.longitude = self.mapView.userLocation.coordinate.longitude
        self.mapView.zoomLevel = 15
        
        
        
        self.mapView.addAnnotation(self.pin)
        
        
        //        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute:
        //            {
        self.mapView.showAnnotations([self.pin], animated: true)

    }


    //搜索周边的停车场
    func getNearbyInformation() {
//        let params = ["latitude":mapView.userLocation.coordinate.latitude,"longitude":mapView.userLocation.coordinate.longitude]
        do{
            
//            let opt = try HTTP.GET("http://139.196.72.74/api/v1/front/region",parameters: params)
                  let opt = try HTTP.GET("http://139.196.72.74/api/v1/front/region/2")
            opt.start{response in
            
                if let err = response.error{
                    print("error:\(err.localizedDescription)")
                    return
                }
                
                print("获得的附近车位数据:\(response.description)")
                //赋值
                let json = JSON(response.data)
                
                self.manyAnnotation.removeAll()
                    self.mapView.removeAnnotations(self.mapView.annotations)

                for i in 0...json["result"].count-1 {
                    if json["result"][i]["status"] == 1{
                    self.parkInformation.append(json["result"][i].dictionaryObject!)
                    }
                }
                
                
                
                //测试
   
                
                
               
                for i in 0...self.parkInformation.count-1
                    
                {
                    
                    
                    
                    let pointAnnotation = MAPointAnnotation()
                    pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: self.parkInformation[i]["latitude"] as! CLLocationDegrees, longitude: self.parkInformation[i]["longitude"] as! CLLocationDegrees)
                    pointAnnotation.title = self.parkInformation[i]["name"] as! String
                    pointAnnotation.subtitle = self.parkInformation[i]["address"] as! String
                    self.manyAnnotation.append(pointAnnotation)

                }
                
                print(self.manyAnnotation)
            
                
                
                self.mapView.addAnnotations(self.manyAnnotation)
             self.mapView.showAnnotations(self.manyAnnotation, animated: true)
  
    
            }
            
            
        }catch let error{
            print("请求失败:\(error)")
        }
    }
    


    

    
    override func viewWillAppear(_ animated: Bool) {
       
        // Clear the last values.
        parkInformation.removeAll()
        
        //我的出租车位网络请求
        do{
            let opt = try HTTP.GET("http://139.196.72.74/api/v1/front/user/place", headers: ["authorization":self.token])
            opt.start{response in
                if let err = response.error{
                    print("error:\(err.localizedDescription)")
                    return
                }
                let json = JSON(response.data)
                var myParkPlace = [[String:Any]]()
                for i in 0...json["result"].count-1 {
                    myParkPlace.append(json["result"][i].dictionaryObject!)
                }
                print("!!!")
                self.baseInfo.cacheSetDic(key: "info", value: myParkPlace)
                
            }
            
            
        }catch let error{
            print("请求失败:\(error)")
        }

        
        
        // map
        if mapView == nil{
        mapView = MAMapView(frame: view.bounds)
        view.addSubview(mapView)
        }
        mapView.removeAnnotations(manyAnnotation)
        mapView.removeOverlays(mapView.overlays)
       
        view.bringSubview(toFront: panelView)
        mapView.delegate = self
 
        
        //定位信息
       mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        

        
        getNearbyInformation()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:
                    {
        self.pin = MyPinAnnotation()
                        self.pin.isLockedToScreen = true
                        self.pin.lockedScreenPoint = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)

          self.pin.coordinate.latitude = self.mapView.userLocation.coordinate.latitude
                        self.pin.coordinate.longitude = self.mapView.userLocation.coordinate.longitude
        print("大头针信息\n\n\n\n\(self.mapView.userLocation.coordinate)")
               
      
        //        pin.coordinate.latitude = mapView.centerCoordinate.latitude
        //        pin.coordinate.longitude = mapView.centerCoordinate.longitude
        

        
        
        
        
        self.mapView.addAnnotation(self.pin)
        
        //        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute:
        //            {
       
        self.mapView.showAnnotations([self.pin], animated: true)
        self.clikLocation()
        
        //        })
        })
    
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sign = base.cacheGetString(key: "sign")
        token = self.sign
        //
        
       

        
        
        //walkManager
        walkManager = AMapNaviWalkManager()
        walkManager.delegate = self
        
        
        //nav
        self.navigationItem.titleView = UIImageView(image:#imageLiteral(resourceName: "login_app_nameNew"))
//        self.navigationItem.leftBarButtonItem?.image=UIImage(named:"user_center_icon")?.withRenderingMode(.alwaysOriginal)
//        self.navigationItem.rightBarButtonItem?.image=UIImage(named:"parkTo")?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //rea
         let revealVC = revealViewController()!
            revealVC.rearViewRevealWidth = 280
        
        
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - 大头针动画
    func pinAnimation() {
        //坠落效果，y轴加位移
        let endFrame = pinView.frame
        pinView.frame = endFrame.offsetBy(dx: 0, dy: -15)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
            self.pinView.frame = endFrame
        }, completion: nil)
    }
    
    // MARK: - MapView Delegate
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay is MAPolyline{
            
            pin.isLockedToScreen = false
            
            //让点击后地图缩放到路线大小
            mapView.visibleMapRect = overlay.boundingMapRect
            
            let renderer = MAPolylineRenderer(overlay: overlay)
            renderer?.lineWidth = 8.0
            renderer?.strokeColor = UIColor.blue
            
            return renderer
        }
        return nil
    }
    
    
    //点击时操作
    
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        
        //start = pin.coordinate
        //修改，注删除
        
        start = mapView.userLocation.coordinate
        end = view.annotation.coordinate
        
        let startPoint = AMapNaviPoint.location(withLatitude: CGFloat(start.latitude), longitude: CGFloat(start.longitude))!
        let endPoint = AMapNaviPoint.location(withLatitude: CGFloat(end.latitude), longitude: CGFloat(end.longitude))!
        DispatchQueue.main.async {
        self.walkManager.calculateWalkRoute(withStart: [startPoint], end: [endPoint])
        }
        
        testLatitude=view.annotation.coordinate.latitude
        print(testLatitude)
    }
    
    func mapView(_ mapView: MAMapView!, didAddAnnotationViews views: [Any]!) {
        let aViews = views as! [MAAnnotationView]
        
        for aView in aViews {
            guard aView.annotation is MAPointAnnotation else {
                continue
            }
            
            aView.transform = CGAffineTransform(scaleX:0,y:0)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
                aView.transform = .identity
            }, completion: nil)
        }
    }
    
    
    /// 用户移动地图的交互
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - wasUserAction: 用户是否移动
    func mapView(_ mapView: MAMapView!, mapDidMoveByUser wasUserAction: Bool) {
        if wasUserAction{
          
            pin.isLockedToScreen = true
            pinAnimation()
          
        }
    }
    
    

    
    
    
    /// 自定义大头针视图
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - annotation: 标注
    /// - Returns: 大头针视图
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        //用户定义的位置，不需要自定义
        if annotation is MAUserLocation{
            return nil
        }
        
        if annotation is MyPinAnnotation{
            let reUserID = "anchor"
            var av = mapView.dequeueReusableAnnotationView(withIdentifier: reUserID)
            if av == nil{
                av = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reUserID)
            }
            
            av?.image = #imageLiteral(resourceName: "homePage_wholeAnchor")
            av?.canShowCallout = false
            
            
            pinView = av
            return av
        }
        
        
        let reUseID = "myID"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reUseID) as? MAPinAnnotationView
        
        if annotationView == nil{
            annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reUseID)
        }
        
        
        annotationView?.image=#imageLiteral(resourceName: "HomePage_nearbyPark")
        annotationView?.canShowCallout = true
        annotationView?.animatesDrop = true
       
        var button : UIButton
        button = UIButton(frame:CGRect(x: 0, y: 0, width: 50, height: 25))
        button.setTitle("开锁", for: .normal)
                button.backgroundColor = UIColor.blue
                button.layer.cornerRadius = 10
                button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        
                //button点击
               button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
//                self.addSubview(button)

        annotationView?.rightCalloutAccessoryView = button
        
        return annotationView
        
    }
    
    
    
        func tapped(_ button:UIButton) {
            for i in 0...self.parkInformation.count-1
                
            {
                if testLatitude == parkInformation[i]["latitude"] as! Double{
                    print("true \(i)")
                    tag = i
                    break
                }

            }
            performSegue(withIdentifier: "showParkInfo", sender: self)
            
        
    }
    
    // MARK: - AMapNaviWalkManagerDelegate 导航代理
    func walkManager(onCalculateRouteSuccess walkManager: AMapNaviWalkManager) {
        print("步行路线规划成功")
        mapView.removeOverlays(mapView.overlays)
        
        var coordinates = walkManager.naviRoute!.routeCoordinates!.map {
            return CLLocationCoordinate2D(latitude: CLLocationDegrees($0.latitude), longitude: CLLocationDegrees($0.longitude))
        }
        
        let polyline = MAPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
        mapView.add(polyline)
        
        //提示距离和用时
        let walkMinute = walkManager.naviRoute!.routeTime / 60
        
        var timeDesc = "1分钟以内"
        
        if walkMinute > 0 {
            timeDesc = String(Int(walkManager.naviRoute!.routeLength.description)!/120) + "分钟"
        }
        
        let hintTitle = "驾车" + timeDesc
        let hintSubtile = "距离" + walkManager.naviRoute!.routeLength.description + "米"
        
        FTIndicator.setIndicatorStyle(.dark)
        FTIndicator.showNotification(with: #imageLiteral(resourceName: "clock"), title: hintTitle, message: hintSubtile)
    }
    
    func walkManager(_ walkManager: AMapNaviWalkManager, error: Error) {
        print("路径规划失败",error)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
      //  var number = ""
      //  var location = ""
      //  var money = ""
        if segue.identifier == "showParkInfo"{
            let destVC = segue.destination as! UnlockController
          
           destVC.token = token
            destVC.number = String(parkInformation[tag]["id"] as! Int)
            destVC.location = parkInformation[tag]["name"] as! String
            destVC.money = String(parkInformation[tag]["price"] as! Double)

            
           
            
            
            
        }
        if segue.identifier == "myParkPlace"{
            

            

           
//            //我的出租车位网络请求
//            do{
//                let opt = try HTTP.GET("http://139.196.72.74/api/v1/front/user/place", headers: ["authorization":self.token])
//                opt.start{response in
//                    if let err = response.error{
//                        print("error:\(err.localizedDescription)")
//                        return
//                    }
//                    let json = JSON(response.data)
//                    var myParkPlace = [[String:Any]]()
//                    for i in 0...json["result"].count-1 {
//                        myParkPlace.append(json["result"][i].dictionaryObject!)
//                    }
//                    print("!!!")
//                        self.baseInfo.cacheSetDic(key: "info", value: myParkPlace)
//                    
//                }
//                
//                
//            }catch let error{
//                print("请求失败:\(error)")
//            }

            
            let destVC = segue.destination as! MyParkingInfoController
            destVC.token = token
//            destVC.myParkPlace = myParkPlace
            

        }
    }
}


