
//  Scrumptious APP
//
//  Created by mohamed ayed
//


import SwiftUI

struct MainView: View {
    @StateObject var order = Order()
   
    @State private var badgeNumber: Int = 10
     private var badgePosition: CGFloat = 1
     private var tabsCount: CGFloat = 1

    var body: some View {
        
        GeometryReader { geometry in
             ZStack(alignment: .bottomLeading) {
               // TabView
               TabView {
                ContentView()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }.environmentObject(order)
    
                
             
                OrderView()
                   .tabItem {
                     Image(systemName: "cart")
                     Text("Cart")
                        
                   }.environmentObject(order)
                
                
                ProfileView()
                .tabItem {

                    Label("Profile",systemImage:"person")

                }.environmentObject(order)
                

                
               }.accentColor(Color.themeColor)

               // Badge View
              
                if order.items.count > 0 {
                    
                    ZStack {
                      Circle()
                        .foregroundColor(.red)

                      Text("\(order.items.count)")
                        .foregroundColor(.white)
                        .font(Font.system(size: 12))
                    }
                    .frame(width: 20, height: 20)
                    .offset(x: ( ( 2 * self.badgePosition) - 1 ) * ( geometry.size.width / ( 2 * self.tabsCount ) ), y: -30)
                    .opacity(self.badgeNumber == 0 ? 0 : 1)
                    
                    
                }
                
                
             }
           }
         }
        
        
        
        
    }


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Order())
    }
}
