
//  Scrumptious APP
//
//  Created by mohamed ayed
//


import SwiftUI

struct menuTabbedView: View {
    @Binding var selectedSegment:Int
    @Namespace var name
    var body: some View {
      
           HStack{
                Button(action:{
                    withAnimation(.spring()){
                        
                        selectedSegment = 1
                        
                        
                    }
                }){
                    
                    VStack{
                        
                        
                        Text(StringConstants.FoodMenu)
                            .font(.system(size:20))
                            .foregroundColor((self.selectedSegment == 0) ? Color.black : Color.gray)
                        
                        
                        
                        ZStack{
                            Capsule()
                                .fill(Color.black.opacity(0.1))
                                
                                .frame(height:4)
                            if selectedSegment == 1{
                                
                                Capsule()
                                    .fill(Color.themeColor)
                                    .frame(height:4)
                                    .matchedGeometryEffect(id: "TAP", in: name)
                                
                                
                                
                            }
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                
                Button(action:{
                    
                    withAnimation(.spring()){
                        
                        selectedSegment = 2
                        
                        
                    }
                }){
                    
                    VStack{
                        Text(StringConstants.ForzenFoodMenu)
                            .font(.system(size:20))
                            .foregroundColor((self.selectedSegment == 1) ? Color.black : Color.gray)
                        ZStack{
                            Capsule()
                                .fill(Color.black.opacity(0.1))
                                
                                .frame(height:4)
                            if selectedSegment == 2{
                                
                                Capsule()
                                    .fill(Color.themeColor)
                                    .frame(height:4)
                                    .matchedGeometryEffect(id: "TAP", in: name)
                                
                                
                                
                            }
                        }
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
            }
            
         
            
            
            
       
        
        
    }
}

struct menuTabbedView_Previews: PreviewProvider {
    static var previews: some View {
        menuTabbedView(selectedSegment: .mock(0))
    }
}
