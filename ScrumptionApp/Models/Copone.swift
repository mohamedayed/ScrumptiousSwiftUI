
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import Foundation
import SwiftyJSON
struct Output:Identifiable,Decodable{
    var id =  UUID()
    //"result":1517,"error":0,"success":1,"msg":1517}}
    var result:String?
    var error:String?
    var success:String?
    var msg:String?

    init?(dict:[String:JSON]) {
        if let result = dict["result"]?.stringValue{
            self.result = result
        }
        
        if let error = dict["error"]?.stringValue{
            self.error = error
            
            
        }
        
        if let success = dict["success"]?.stringValue{
            self.success = success
        }
        
        if let msg = dict["msg"]?.stringValue{
            self.msg = msg
        }
        
    }
    
}
struct Copone:Identifiable,Decodable{
    

    
    var  id =  UUID()
    var title:String?
    var code:String?
    var cost_type:String?
    var value: String?
    var min_order:String?
    var end_date:String?
    var coupon_use:String?
    var customer_use: String?
    var publish:String?
    var coupon_value:String?
    var categories:String?
    
    var symbol: String?
    
    
    
    
    init?(dict:[String:JSON]) {
        
        if let title = dict["title"]?.stringValue{
            
            self.title = title
            
        }
        
        
        if let code = dict["code"]?.stringValue{
            self.code = code
            
        }
        
        if let cost_type = dict["cost_type"]?.stringValue{
            self.cost_type = cost_type
            
        }
        if let value = dict["value"]?.stringValue{
            self.value = value
            
        }
        if let min_order = dict["min_order"]?.stringValue{
            self.min_order = min_order
            
        }
        if let end_date = dict["end_date"]?.stringValue{
            self.end_date = end_date
            
        }
        if let coupon_use = dict["coupon_use"]?.stringValue{
            self.coupon_use = coupon_use
            
        }
        if let customer_use = dict["customer_use"]?.stringValue{
            self.customer_use = customer_use
            
        }
        if let publish = dict["publish"]?.stringValue{
            self.publish = publish
            
        }
        if let coupon_value = dict["coupon_value"]?.stringValue{
            self.coupon_value = coupon_value
            
        }
        if let categories = dict["categories"]?.stringValue{
            self.categories = categories
            
        }
        if let symbol = dict["symbol"]?.stringValue{
            self.symbol = symbol
            
        }
        
    }
    
    
    
    
    
}
