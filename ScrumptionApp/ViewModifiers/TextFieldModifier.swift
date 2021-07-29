
//  Scrumptious APP
//
//  Created by mohamed ayed
//


import Foundation
import SwiftUI

struct TextFieldModifier :ViewModifier{
    
    
    func body(content: Content) -> some View {
        content.padding(10)
            
            .background(Color(.white))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
            .autocapitalization(.none)

    }
    
    
    
    
}

extension HStack{
    
    
    func TFModifier() -> some View{
        
        
        return self.modifier(TextFieldModifier())
        
    }
    
    
}
