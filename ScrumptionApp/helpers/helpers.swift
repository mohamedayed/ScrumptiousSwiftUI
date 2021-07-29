
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import Foundation
class helpers{

    
    
    
        
       class  func MenuData()->[DrawerMenuItems]  {
            //Food Menu/frozen/cart/orders profile/logout
            var menus = [DrawerMenuItems]()
            let item1   = DrawerMenuItems(id: "1", title: "Food Menu", icon: "menu")
            let item2   = DrawerMenuItems(id: "2", title: "Frozen", icon: "frozen")
            let item3   = DrawerMenuItems(id: "3", title: "Cart", icon: "cart")
            let item4   = DrawerMenuItems(id: "4", title: "Orders", icon: "orders")
            let item5   = DrawerMenuItems(id: "5", title: "Profile", icon: "profile")
            let item6   = DrawerMenuItems(id: "6", title: "Logout", icon: "logout")
            
            menus.append(item1)
            menus.append(item2)
            menus.append(item3)
            menus.append(item4)
            menus.append(item5)
            menus.append(item6)
              
         return menus
        }
        
        
    

    
    
    
    class func setApiTokenType(tokenType:String){
        
        let def  = UserDefaults.standard
        def.setValue(tokenType,forKey:"token_type")
        def.synchronize()
        
    }
    
    class func getApiTokenType()->String?{
        let def = UserDefaults.standard
        
        return def.object(forKey: "token_type") as? String
    }
    
    
    
    class func setApiToken(token:String){
        
        let def = UserDefaults.standard
        def.setValue(token, forKey: "api_token")
        def.synchronize()
        
        
    }
    
    
    
    class func removeAPiToken(){
        
        let def = UserDefaults.standard
        
        def.removeObject(forKey: "api_token")
        def.synchronize()
        
    }
    
    class func getApiToken()->String?{
        let def = UserDefaults.standard
        
        return def.object(forKey: "api_token") as? String
        
        
    }
    
    
    class func setAppointCount(count:Int){
        let def  = UserDefaults.standard
        
        def.setValue(count, forKey: "appointmentCount")
        def.synchronize()
        
        
    }
    
    
    class func getAppointCount()->Int?{
        
        let def = UserDefaults.standard
        
        return def.object(forKey: "appointmentCount") as? Int
        
        
    }
    
    
    class func setCoponeCode(count:Int){
        let def  = UserDefaults.standard
        
        def.setValue(count, forKey: "coponeCode")
        def.synchronize()
        
        
    }
    
    
    class func getCoponeCode()->Int?{
        
        let def = UserDefaults.standard
        
        return def.object(forKey: "coponeCode") as? Int
        
        
    }
    
    
    
    class func removeCodeCopone(){
        
        let def  = UserDefaults.standard
        
        def.removeObject(forKey: "coponeCode")
        
        
    }
    
}
