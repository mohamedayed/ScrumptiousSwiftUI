
//  Scrumptious APP
//
//  Created by mohamed ayed
//


import Foundation
import SwiftUI
struct ArrowShape: Shape{
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path  in
            
            path.move(to: CGPoint(x:0,y:0))
            path.addLine(to: CGPoint(x:rect.width,y:0))
            path.addLine(to: CGPoint(x:rect.width,y:rect.height - 10))
            
            
            
            path.addLine(to: CGPoint(x:(rect.width/2)-10,y:rect.height - 10))
            path.addLine(to: CGPoint(x:(rect.width/2),y:rect.height))
            path.addLine(to: CGPoint(x:(rect.width/2)+10,y:rect.height - 10))
            
            path.addLine(to: CGPoint(x:0,y:rect.height - 10))
            
            
            
        }
        
    }
    
    
}
