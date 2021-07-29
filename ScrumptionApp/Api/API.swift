
//  Scrumptious APP
//
//  Created by mohamed ayed
//


import Foundation
import Alamofire
import SwiftyJSON
import Combine

var bag = Set<AnyCancellable>()
class API {
    
    
        
        class func headers() -> HTTPHeaders {
            var headers: HTTPHeaders = [
                "Accept-Language":"en",
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
            
            if let authToken = UserDefaults.standard.string(forKey: "auth_token") {
                headers["Authorization"] = "Token" + " " + authToken
            }
            
            return headers
        }
    
    static func getHomeFoodMenu(dict:[String:Any],completion:@escaping (_ error:Error?,_ foodMenuCat:FoodMenuCat?)->Void){
        let enc = URLEncoding(arrayEncoding: .noBrackets)
        
        let url = Urls.getCompaniesUrl
        AF.request(url, method: .get,encoding:URLEncoding.default, headers: nil)
            .publishDecodable(type:FoodMenuCat.self)
            .sink(receiveCompletion: { completionLib in
                
                switch(completionLib){
                
                case .finished:
                    ()
                case .failure(let error):
                    
                    print(error.localizedDescription)
                
                }
                
                
            }, receiveValue: { response in
                //debugPrint("\(response)Hadeer")
                switch response.result{
                
                case .success(let foodMenuCat):
                    
                    completion(nil,foodMenuCat)
                    
                case .failure(let error):
                    
                    completion(error,nil)
                
                }
                
                
            }).store(in: &bag)
        
   
    }
    
    
    class func getMenu(dict:[String:Any],completion:@escaping (_ error:Error?,_ success:Bool?)->Void){
        let enc = URLEncoding(arrayEncoding: .noBrackets)
        
        let url = Urls.getCompaniesUrl
        
        AF.request(url, method: .post, parameters: dict, encoding:enc, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                   print(error)
                    completion(error,nil)
                case .success(let value):
                    
                    let json = JSON(value)
                    print("\(json)DHJSON")
                  

//
                    
                    completion(nil,true)
                    
                   // print("this my print \(specs)")
                    
                    
                    
                }
                
                
        }
        
    }
    
    
    
    
//
//    class func getFoodMenu(dict:[String:Any],completion: @escaping (_ error: Error?, _ foodMenuCat: MenuOutput?)->Void) {
//        let enc = URLEncoding(arrayEncoding: .noBrackets)
//
//        let url = Urls.getCompaniesUrl
//            AF.request(url, method: .post, parameters: dict, encoding:URLEncoding.default, headers: nil)
//                 .responseDecodable(of:MenuOutput.self) { (response) in
//
//            switch response.result
//            {
//            case .failure(let error):
//                print(error)
//                completion(error, nil)
//
//            case .success(let value):
//                let json = JSON(value)
//                print(json)
//
//
//                completion(nil, value)
//
//
//            }
//
//        }
//    }
//
    
    
    
    
    

    class func getFoodMenu(dict:[String:Any],completion: @escaping (_ error: Error?, _ foodMenuCat: [FoodMenuCat]?,_ foodMenuItem: [FoodMenuItem]?)->Void) {
        let enc = URLEncoding(arrayEncoding: .noBrackets)

        let url = Urls.getCompaniesUrl
        AF.request(url, method: .post, parameters: dict, encoding:enc, headers: nil)
            .responseJSON { response in

            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error, nil,nil)

            case .success(let value):
                let json = JSON(value)
                
                //debugPrint(response)
               // print("\(json)hager")

                guard let foodMenuCatData = json["output"]["result"].array else {
                    completion(nil, nil,nil)
                    return
                }
                
                var foodMenuItem = [FoodMenuItem]()
                var foodMenuCatList = [FoodMenuCat]()
                
               // var foodMenuCatData = FoodMenuCat(dict: data)
                
                
                foodMenuCatData.forEach({
                    if let dataFoodMenuCatItem = $0.dictionary, var menuCatItems = FoodMenuCat(dict: dataFoodMenuCatItem){
                        
                        if let dataFoodItem = dataFoodMenuCatItem["items"]?.array{
                            dataFoodItem.forEach({
                                if let dataFoodMenuItem = $0.dictionary, let menuItems = FoodMenuItem(dict: dataFoodMenuItem){
                                   //menuCatItems.items?.append(contentsOf: menuItems)
                                    menuCatItems.items?.append(menuItems)
                                   //menuCatItems.title =""
                                    foodMenuItem.append(menuItems)
                                    
                                    
                                    
                                    
                                    
                                }

                            })
                        }
                        
                        foodMenuCatList.append(menuCatItems)
                    }

                })
                
              //  print("DETa\(data["clinics"]?.array)")
         
              
                
         

                completion(nil, foodMenuCatList,foodMenuItem)


            }

        }
    }

    
    
    
     
    class func getCompanies(dict:[String:Any],completion:@escaping (_ error:Error?,_ company:[Companies]?)->Void){
        let enc = URLEncoding(arrayEncoding: .noBrackets)
        
        let url = Urls.getCompaniesUrl
        
        AF.request(url, method: .post, parameters: dict, encoding:enc, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                   print(error)
                    completion(error,nil)
                case .success(let value):
                    
                    let json = JSON(value)
                   // print("\(json)DHJSON")
                  
                    var companiesList = [Companies]()
                    
                    
                    guard let companies = json["output"]["msg"].array else{
                        completion(nil,nil)
                        
                        return
                    }
                    
                    //print("heres\(companies)")
                    for comp in companies{

                        if let companyDict = comp.dictionary , let companyItem = Companies.init(dict: companyDict){

                            companiesList.append(companyItem)



                        }
                    }
                    
                    
                    completion(nil,companiesList)
                    
                   // print("this my print \(specs)")
                    
                    
                    
                }
                
                
        }
        
    }
    
    
    
    
    
    class func submitOrder(dict:[String:Any],completion: @escaping (_ error: Error?, _ Output:Output?)->Void) {
        let enc = URLEncoding(arrayEncoding: .noBrackets)
        //Encoding JSONEncoding(options: [])
        let url = Urls.getCompaniesUrl
        AF.request(url, method: .post, parameters: dict, encoding:enc, headers: nil)
            .responseJSON { response in
                    
                print("\(response)amrmero")
            switch response.result
            {
            case .failure(let error):
                
                print("\(error)")
                completion(error, nil)

            case .success(let value):
                let json = JSON(value)
                
               // debugPrint(response)
              //  print("\(json)hager")

                guard let outputData = json["output"].dictionary else {
                    completion(nil, nil)
                    return
                }
                
               
               // var foodMenuCatData = FoodMenuCat(dict: data)
                
                
                let OutDataItem = Output.init(dict: outputData)
                
              //  print("DETa\(data["clinics"]?.array)")
         
              
                
         

                completion(nil, OutDataItem)


            }

        }
    }
    
    
    
    class func checkCoponeCodeValidation(dict:[String:Any],completion: @escaping (_ error: Error?, _ copone:Copone?)->Void) {
        let enc = URLEncoding(arrayEncoding: .noBrackets)

        let url = Urls.getCompaniesUrl
        AF.request(url, method: .post, parameters: dict, encoding:enc, headers: nil)
            .responseJSON { response in

            switch response.result
            {
            case .failure(let error):
                print(error)
                completion(error, nil)

            case .success(let value):
                let json = JSON(value)
                
              //  debugPrint(response)
              // print("\(json)hager")

                guard let outputData = json["output"].dictionary else {
                    completion(nil, nil)
                    return
                }
                
               
               // var foodMenuCatData = FoodMenuCat(dict: data)
                
                
                let coponeDataItem = Copone.init(dict: outputData)
                
              //  print("DETa\(data["clinics"]?.array)")
         
              
                
         

                completion(nil, coponeDataItem)


            }

        }
    }
    
    
    
    
    static func checkCoponeCode(dict:[String:Any],completion:@escaping (_ error:Error?,_ copone:Output?)->Void){
        let enc = URLEncoding(arrayEncoding: .noBrackets)
        
        let url = Urls.getCompaniesUrl
        AF.request(url, method: .post,encoding:enc, headers: nil)
            .publishDecodable(type:Output.self)
            .sink(receiveCompletion: { completionLib in
                
                switch(completionLib){
                
                case .finished:
                    ()
                case .failure(let error):
                    
                    print(error.localizedDescription)
                
                }
                
                
            }, receiveValue: { response in
                //debugPrint("\(response)hager")
                switch response.result{
                
                case .success(let copone):
                    
                    completion(nil,copone)
                    
                case .failure(let error):
                    
                    completion(error,nil)
                
                }
                
                
            }).store(in: &bag)
        
   
    }
    
    
    class func UpdateProfile(dict:[String:Any],completion:@escaping (_ error:Error?,_ success:Bool?,_ user:User?)->Void){
        let enc = URLEncoding(arrayEncoding: .noBrackets)
        
        let url = Urls.baseUrl
        var token = ""
        
        AF.request(url, method: .post, parameters: dict, encoding:enc, headers: nil)
            .responseJSON { (response) in
                
               debugPrint(response)
                switch response.result {
                case .failure(let error):
                   print("\(error)DHERROR")
                    
                    completion(error,nil,nil)
                case .success(let value):
                    
                    let json = JSON(value)
                    print("\(json)DHJSON")
                      
                    guard let users = json["output"]["msg"]["data"].dictionary else{
                        completion(nil,nil,nil)
                        
                        return
                    }
                    
                    //print("heres\(companies)")
                  let userInfo = User.init(dict: users)
                      
                      //print("heres\(companies)")
                    
                    if let success = json["output"]["success"].int {
                       
                     
                        if success == 0{
                            completion(nil, nil,nil)
                        }else{
                            
                             
                            
                            
                            
                            completion(nil,true,userInfo)
                        }
                 
                        
                    }
                    
                    
                    
                }
                
                
        }
        
        
        
    }
    
    
    
    
    class func Register(dict:[String:Any],completion:@escaping (_ error:Error?,_ success:Bool?,_ token:String?,_ user:User?)->Void){
        let enc = URLEncoding(arrayEncoding: .noBrackets)
        
        let url = Urls.baseUrl
        var token = ""
        
        AF.request(url, method: .post, parameters: dict, encoding:enc, headers: nil)
            .responseJSON { (response) in
                
               // debugPrint(response)
                switch response.result {
                case .failure(let error):
                   print(error)
                    completion(error,nil,"",nil)
                case .success(let value):
                    
                    let json = JSON(value)
                    print("\(json)DHJSON")
                      
                      guard let users = json["output"]["data"].dictionary else{
                          completion(nil,nil,"",nil)
                          
                          return
                      }
                      
                      //print("heres\(companies)")
                    let userInfo = User.init(dict: users)
                    
                    print("\(userInfo)")
                    
                    if let api_token = json["output"]["msg"]["token"].string {
                       
                     
                       let token = api_token
                       // helpers.setApiToken(token: api_token)

                       
                        // save api token to UserDefaults
                        //helper.saveApiToken(token: api_token)

                        completion(nil, true,token,userInfo)
                    }
                   // print("this my print \(specs)")
                    
                    
                    
                }
                
                
        }
        
        
        
    }
  
    class func Login(dict:[String:Any],completion:@escaping (_ error:Error?,_ success:Bool?,_ token:String?,_ user:User?)->Void){
        let enc = URLEncoding(arrayEncoding: .noBrackets)
        
        let url = Urls.baseUrl
        
        AF.request(url, method: .post, parameters: dict, encoding:enc, headers: nil)
            .responseJSON { (response) in
                
                //debugPrint(response)
                switch response.result {
                case .failure(let error):
                   print(error)
                    completion(error,nil,"",nil)
                case .success(let value):
                    
                    let json = JSON(value)
                    print("\(json)DHJSON")
                  
                    
                    guard let users = json["output"]["msg"]["data"].dictionary else{
                        completion(nil,nil,"",nil)
                        
                        return
                    }
                    let userInfo = User.init(dict: users)
                    
                    if let api_token = json["output"]["msg"]["token"].string {
                        print("api_token: \(api_token)")

                        helpers.setApiToken(token: api_token)
                            
                        
                       
                        // save api token to UserDefaults
                        //helper.saveApiToken(token: api_token)

                        completion(nil, true,api_token,userInfo)
                    }
                   //print("userInfo \(userInfo)")
                    
                    
                    
                }
                
                
        }
        
        
        
    }
    
    
    
    
    
    class func getBranches(dict:[String:Any],completion:@escaping (_ error:Error?,_ brach:[Branches]?)->Void){
        let enc = URLEncoding(arrayEncoding: .noBrackets)
        
        let url = Urls.getCompaniesUrl
        
        AF.request(url, method: .post, parameters: dict, encoding:enc, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                   print(error)
                    completion(error,nil)
                case .success(let value):
                    
                    let json = JSON(value)
                   // print("\(json)DHJSON")
                  
                    var branchesList = [Branches]()
                    
                    
                    guard let branches = json["output"]["msg"].array else{
                        completion(nil,nil)
                        
                        return
                    }
                    
                    //print("heres\(companies)")
                    for bran in branches{

                        if let branchDict = bran.dictionary , let branchItem = Branches.init(dict: branchDict){

                            branchesList.append(branchItem)



                        }
                    }
                    
                    
                    completion(nil,branchesList)
                    
                   // print("this my print \(specs)")
                    
                    
                    
                }
                
                
        }
        
    }
    
    
    
    
    
   

  
    
}
