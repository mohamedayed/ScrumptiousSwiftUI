
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import SwiftUI
import SwiftyJSON


struct FoodMenuCat:Decodable,Identifiable,Equatable{
    var id =  UUID()
    var cat_id:Int?
    var title: String?
    var items: [FoodMenuItem]? = [FoodMenuItem]()
    
    
    init?(dict:[String:JSON]) {
        
        if let cat_id = dict["id"]?.intValue{
            
            self.cat_id = cat_id
            
        }
        
        
        if let title = dict["title"]?.stringValue{
            self.title = title
            
        }
        if let items = dict["items"]?.array{
        
            
           // print("items\(self.items)")
            
            //self.items = items
        }
        
        
        
    }
}


struct foodMenuOrderItems:Equatable,Encodable{
    
    var itemid:Int?
    var qty:Int?
    var item_type:String?
    
    
}

struct FoodMenuItem:Identifiable,Equatable,Decodable {
    var id =  UUID()
    var item_id: Int?
    var item_category:String?
    var price:Double?
    var item_title:String?
    var item_picture:String?
    var item_qty:Int?
    var item_type:String?
    
    var itemqty:String{
        if let itemqtyValue = item_qty{
            return "\(String(describing: itemqtyValue)) X"
        }
        
        return "1"
        
    }
    
    var item_price:Double{
        
        if let itemqtyData = item_qty,let priceData = price{
            return Double(priceData * Double(itemqtyData))
        }
        
        return 0.0
        
        
        
    }
    
    var thumbnailImage:String{
        
        if let itemPicData = item_picture{
            
        
    
        return "https://www.pplmx.com/scrumptious/route/image.php?img=pic&w=50&w=50&img=pic&src=\(String(describing: itemPicData))"
    
        }
        
        
        return "https://www.pplmx.com/scrumptious/route/image.php?img=pic&w=50&w=50&img=pic&src=1482048525_1965419101_71276903.jpg"
    }
    
    
    var fullImage:String{
        
        if let itemPicData = item_picture{

            
            return "https://www.pplmx.com/scrumptious/route/image.php?img=pic&w=400&w=400&img=pic&src=\(String(describing: itemPicData))"
                }
            return "https://www.pplmx.com/scrumptious/route/image.php?img=pic&w=400&w=400&img=pic&src=1482048525_1965419101_71276903.jpg"
        
        
        }
        
        
        
    var itemprice:String{
        if let priceValue = price{
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        
            return formatter.string(from: NSNumber(value: Double(priceValue))) ?? "EGP0"
        
        
        
        }
        
        
        return "EGP0"
    }

    
    

    

    #if DEBUG
    static let example = FoodMenuItem(item_id: 30, item_category: "69", price: 20, item_title: "Leb. Chicken Shawerma", item_picture: "https://www.pplmx.com/scrumptious/route/image.php?img=pic&w=400&w=400&img=pic&src=1482048525_1965419101_71276903.jpg")
    #endif
}


extension FoodMenuItem{
    
    
    
    
    init?(dict:[String:JSON]) {

        if let item_id = dict["item_id"]?.intValue{

            self.item_id  = item_id

        }


        if let item_category = dict["item_category"]?.stringValue{
            self.item_category  = item_category

        }

        if let price = dict["price"]?.doubleValue{
            self.price  = price

        }

        if let item_title = dict["item_title"]?.stringValue{
            self.item_title  = item_title

        }

        if let item_picture = dict["item_picture"]?.stringValue{

            self.item_picture = item_picture


        }

    }
    
}


