
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import Foundation
import SwiftyJSON

struct Branches:Identifiable{
    
    let name:String
    let id:Int
    let agent:Int

    
    init?(dict:[String:JSON]) {
        guard let name = dict["name"]?.stringValue,let id = dict["id"]?.intValue,let agent = dict["agent"]?.intValue else {return nil}
        
        self.name = name
        self.id = id
        self.agent = agent
    
        
        
    }
    
    
}

