
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import SwiftUI


struct TopBar : View {
    
    @Binding var selected : Int
    
    var body : some View{
        
        HStack{
            
            Button(action: {
                withAnimation{
                    
                    self.selected = 1
                }
                
                
                
            }) {
                HStack(spacing:15){
                    
               
                Image(systemName: "person.badge.plus")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.vertical,12)
                    .padding(.horizontal,10)
                    
                    
                  
                    Text("Login").transition(.move(edge: .bottom))
                }
                .frame(width: UIScreen.main.bounds.width/2 - 30)
                .background(self.selected == 1 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
                
            }
            .foregroundColor(self.selected == 1 ? Color(hex: AppColors.primaryDark) : .gray)
           
            
            
            
            
            
            Button(action: {
                
                withAnimation{
                    self.selected = 2
                }
                
                
            }) {
                HStack(spacing:15){
                    
               
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.vertical,12)
                    .padding(.horizontal,10)
                    
                    
                  
                  Text("Register")
                }
                .background(self.selected == 2 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
                
            }
            .foregroundColor(self.selected == 2 ? Color.themeColor : .gray)
           
          
            
            
            
            
            }.padding(8)
        .frame(width:UIScreen.main.bounds.width - 30)
        .background(Color.themeBackground)
            .clipShape(Capsule())
            
        .animation(.default)
        
    }
}



struct TopBar_Previews: PreviewProvider {
    
    static var previews: some View {
        TopBar(selected: .constant(2))
            .previewDevice("iphone SE")
    }
}
