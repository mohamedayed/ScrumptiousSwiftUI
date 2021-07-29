
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import Foundation
import SwiftyJSON
struct Companies:Identifiable{
    
    let id:Int
    let code:String
    init?(dict:[String:JSON]) {
        
        guard let id = dict["id"]?.intValue,let code = dict["code"]?.stringValue else {return nil}
        
        self.id = id
        self.code = code
        
        
    }
    
    
}
