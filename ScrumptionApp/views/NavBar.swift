
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import SwiftUI

struct NavBar: View {
    @Binding var showMenu:Bool
    @Binding var darkMode:Bool
    var body: some View {
        
            
            HStack{
                Button(action:{
                    withAnimation{
                        self.showMenu.toggle()
                    }
                    
                }){
                    Image(systemName:"line.horizontal.3")
                        .resizable()
                        .foregroundColor(.black
                        )
                        .frame(width: 25, height: 25)
                }
                Spacer()
                Text("Scrumptious")
                    .foregroundColor(.black)
               
            
            }.padding()
            .foregroundColor(.white)
           
            
            
            
            
            
        
    }
}





struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(showMenu: .constant(true),darkMode: .constant(false))
    }
}
