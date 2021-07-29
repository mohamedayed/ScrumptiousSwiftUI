////
////  Api+common.swift
////  ScrumptionApp
////
////  Created by mohamed ayed on 3/3/21.
////
//
//import Foundation
//
////=======================================
//
////  Created by Mohamed ayed .
////  Copyright © 2018-2019 Alprogrammer. All rights reserved.
////=======================================
//
//import UIKit
//import Alamofire
//import SwiftyJSON
//
//
//extension API{
//    
//    
//    class func getSpec(type:Int,completion:@escaping (_ error:Error?,_ spec:[Speciality]?)->Void){
//        
//        
//        let url = Urls.SpecURL
//        
//        Alamofire.request(url, method: .get, parameters: nil, encoding:URLEncoding.default, headers: nil)
//            .responseJSON { (response) in
//                switch response.result {
//                case .failure(let error):
//                   print(error)
//                    completion(error,nil)
//                case .success(let value):
//                    
//                    let json = JSON(value)
//                    print(json)
//                    
//                    var specs = [Speciality]()
//                    
//                    
//                    guard let specialities = json.array else{
//                        completion(nil,nil)
//                        print("heres")
//                        return
//                    }
//                    
//                    for speciality in specialities{
//                        
//                        if let speciality = speciality.dictionary , let spec = Speciality.init(dict: speciality){
//                            
//                           specs.append(spec)
//                            
//                            
//                            
//                        }
//                    }
//                    
//                    
//                    completion(nil,specs)
//                    
//                   // print("this my print \(specs)")
//                    
//                    
//                    
//                }
//                
//                SVProgressHUD.dismiss()
//        }
//        
//    }
//    
//    
//    
//    
//    
//    
//    class func getGov(type:Int,completion:@escaping (_ error:Error?,_ gov:[Government]?)->Void){
//        
//        
//        let url = Urls.GovURL
//        
//        Alamofire.request(url, method: .get, parameters: nil, encoding:URLEncoding.default, headers: nil)
//            .responseJSON { (response) in
//                switch response.result {
//                case .failure(let error):
//                    print(error)
//                    completion(error,nil)
//                case .success(let value):
//                    
//                    let json = JSON(value)
//                    print(json)
//                    
//                    var govList = [Government]()
//                    
//                    
//                    guard let govs = json.array else{
//                        completion(nil,nil)
//                        print("heres")
//                        return
//                    }
//                    
//                    for gov in govs{
//                        
//                        if let gov = gov.dictionary , let govItem = Government.init(dict: gov){
//                            
//                            govList.append(govItem)
//                            
//                            
//                            
//                        }
//                    }
//                    
//                    
//                    completion(nil,govList)
//                    
//                    // print("this my print \(specs)")
//                    
//                    
//                    
//                }
//                SVProgressHUD.dismiss()
//        }
//        
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    class func getAreas(city:Int,completion:@escaping (_ error:Error?,_ gov:[Area]?)->Void){
//        
//        
//        let url = Urls.AreaUrl+"\(city)"
//        
////        let parameters = [
////            "city":city
////        ]
//        
//        Alamofire.request(url, method: .get, parameters: nil, encoding:URLEncoding.default, headers: nil).debugLog()
//            .responseJSON { (response) in
//                switch response.result {
//                case .failure(let error):
//                    print(error)
//                    completion(error,nil)
//                case .success(let value):
//                    
//                    let json = JSON(value)
//                    print("JSONAREA\(json)|ID|\(city)")
//                    
//                    var areaList = [Area]()
//                    
//                    
//                    guard let areas = json.array else{
//                        completion(nil,nil)
//                        print("heres")
//                        return
//                    }
//                    
//                    for area in areas{
//                        
//                        if let area = area.dictionary , let areaItem = Area.init(dict: area){
//                            
//                            areaList.append(areaItem)
//                            
//                        }
//                    }
//                    
//                    
//                    completion(nil,areaList)
//                    
//                    // print("this my print \(specs)")
//                    
//                    
//                    
//                }
//                SVProgressHUD.dismiss()
//        }
//        
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//}
//
//
