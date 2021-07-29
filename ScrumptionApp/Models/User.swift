
//  Scrumptious APP
//
//  Created by mohamed ayed
//


import Foundation
import SwiftyJSON
struct User:Identifiable,Codable{
    
    
    
    

    var id:Int?
    var location:String?
    var name:String?
    var phone:String?
    var gender:String?
   
    var agent:Int?
    var agent_name:String?
    var email:String?
    var office_number:String?
    var fullname:String?
    var branch_name:String?
    var mobile_number:Int?
    var branch:Int?
    
    
    
    init?(dict:[String:JSON]) {
        if let id = dict["id"]?.intValue{
            self.id  = id
        }
        
        if let location = dict["location"]?.stringValue{
            self.location = location
        }
      
        if let name =  dict["name"]?.stringValue{
            self.name = name
        }
        
        
        if let phone =  dict["phone"]?.stringValue
        {
            self.phone = phone
        }
        
        if let gender = dict["gender"]?.stringValue{
            
            self.gender = gender
            
        }
        if let agent  = dict["agent"]?.intValue{
            
            self.agent = agent
            
        }
        
        if let agent_name  = dict["agent_name"]?.stringValue{
            
            self.agent_name = agent_name
            
        }
        
        if let email = dict["email"]?.stringValue{
            
            self.email = email
            
        }
        
        
        if let office_number = dict["office_number"]?.stringValue{
            
            self.office_number = office_number
            
        }
        if let fullname = dict["fullname"]?.stringValue{
            
            self.fullname = fullname
            
        }
        
        if let branch_name = dict["branch_name"]?.stringValue{
            
            self.branch_name = branch_name
            
        }
        
        if let mobile_number = dict["mobile_number"]?.intValue{
            self.mobile_number = mobile_number
        }
        
       
        
        if let branch = dict["branch"]?.intValue{
            self.branch = branch
        }
        
      
       
       
    }
    
//    public func encode() -> [String: AnyObject] {
//        var dictionary : Dictionary = [String: AnyObject]()
//        dictionary["name"] = name as AnyObject
//        dictionary["continuePage"] = continuePage as AnyObject
//        return dictionary
//    }
    
}
