
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import SwiftUI
import Combine
class Order: ObservableObject {
    @Published var items = [FoodMenuItem]()
    @Published var itemsToSend = [foodMenuOrderItems]()
  
    
    @Published var ApiToken :String = UserDefaults.standard.string(forKey: "ApiToken") ?? ""
    
    @Published var coponeCodeText:String = ""
    var coponeCancellable:AnyCancellable? = nil
    @Published var foodMenuList:[FoodMenuCat]?
    
    var foodMenuFilled:Bool  = false
    @Published var coponeValidMsg:String = ""
    @Published var coponeValid:Bool = false
    
    @Published var copone:Double?
 
    
   
    
    func checkCoponeCode(code:String)->Bool{
        var coponeValid:Bool = false
        if let apiToken = helpers.getApiToken(){
            let dictCoponeCode:[String:Any] = [
                       "_identifier":"API",
                       "_type_params[type]":"checkCodeIOS",
                      "token":apiToken,
                      "_type_params[code]":code
                   ]
            API.checkCoponeCodeValidation(dict: dictCoponeCode){(error:Error?, copone:Copone?) in
                if let min_order = copone?.min_order,let coponeValue = copone?.coupon_value{
                    if self.total > Double(min_order) ?? 0.0{
                        self.coponeValid =  true
                        self.coponeValidMsg = "Copone is Valid"
                        self.copone =  Double(coponeValue) ?? 0.0
                    }else{
                        self.coponeValid = false
                        self.coponeValidMsg = "Copone code is not valid"
                    }
                }
                
                print("\(copone)COPONECODE")
                print("\(self.coponeValid)coponeValid")
            }
            
        }
        return coponeValid
        
        
    }
    
    
    func submitOrder(code:String){
        if let apiToken = helpers.getApiToken(){
            let encoder = JSONEncoder()
            do {
                let result = try encoder.encode(itemsToSend)
                if let resultItemString = String(data: result, encoding: .utf8) {
                    //print("\(resultItemString)Result")
                    let dictOrder:[String:Any] = [
                               "_identifier":"API",
                               "_type_params[type]":"SubmitOrderIOS",
                               "_type_params[items]":resultItemString,
                               "token":apiToken,
                               "_type_params[code]":code
                           ]
                    //print("\(dictOrder)Android")
                    
                    API.submitOrder(dict: dictOrder) { (error:Error?, output:Output?) in
                        print("\(output)hena")
                    }
                    
                }
            } catch {
                print(error)
            }
          
            
        }
        
    }
    
    
    
    func getHomeFoodMenu(type:FoodType){
    
    
        
        
        if let apiToken = helpers.getApiToken(){
            self.foodMenuList = [FoodMenuCat]()
            
            var dictMenu = [String:String]()
            
            switch(type){
            case .food:
             dictMenu = [
                        "_identifier":"API",
                        "type_params[type]":"home",
                        "token":apiToken
                    ]
            
            case .frozen:
             dictMenu = [
                        "_identifier":"API",
                        "type_params[type]":"home",
                        "_type_params[class]":"Frozen",
                        "token":apiToken
                    ]
            
            
            }
            
         
        
              
              print("hadeerApiToken\(String(describing: helpers.getApiToken()))")

              
              API.getFoodMenu(dict: dictMenu) { (error:Error?, foodMenuCat:[FoodMenuCat]?, foodMenuItem:[FoodMenuItem]?) in
               
                  if let foodmenuCatList = foodMenuCat{
                      
                      
                      self.foodMenuList = foodmenuCatList
                      self.foodMenuFilled = true
                    //  print("\(foodmenuCatList)foodmenuCatList")
                      
                      
                  }
            
                  
              }
        }
        
        
 
    

      }

    init() {
        if !self.foodMenuFilled{
           // getHomeFoodMenu()
        }
        
        coponeCancellable = $coponeCodeText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { copone in
               
                if copone == ""{
                    
                }else{
                    
                    self.checkCoponeCode(code: copone)
                    
                }
                
                
            })
        
    }
    

    
    
    var total: Double {
        if items.count > 0 {
            var totalwithoutCopone =  items.reduce(0) { $0 + Double($1.item_price) }
            if let coponeCode  = self.copone,coponeCode != 0.0{
                return totalwithoutCopone - coponeCode
            }else{
                return totalwithoutCopone
            }
            
            
        } else {
            return 0
        }
    }
    
    
    
    
    var totalPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        let total = Double(self.total)
        //let tipValue = total / 100 * Double(tipAmount)

        return formatter.string(from: NSNumber(value: total )) ?? "0 EGP"
    }
 
    
    var itemCount:Int{
        
        //swift5return items.count(where: { $0 == $0 }) // 3
        return items.filter({$0 == $0 }).count
    }

    func add(item: FoodMenuItem) {
        
        if let row = self.items.firstIndex(where: {$0.item_id == item.item_id}) {
            items[row].item_qty = item.item_qty
            itemsToSend[row].qty = item.item_qty
            
        }else{
            items.append(item)
            let orderItem = foodMenuOrderItems(itemid: item.item_id ?? 0, qty: item.item_qty ?? 0,item_type: item.item_type)
            itemsToSend.append(orderItem)
            
        }
        
        
        
        
        print("\(itemsToSend)ADDED")
    }

    func remove(item: FoodMenuItem) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}
