
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import Foundation
import SwiftUI
struct ProgressViewModifier:ViewModifier{
    
    func body(content: Content) -> some View {
        content.padding([.vertical,.horizontal])
            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            .background(Color.black.opacity(0.7))
            .clipShape(Capsule())
    }
    
    
}


extension View{
    
    func ProgressCircle()->some View{
        
        return self.modifier(ProgressViewModifier())
    }
    
    
}
