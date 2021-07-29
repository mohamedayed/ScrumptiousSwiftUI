

//  Scrumptious APP
//
//  Created by mohamed ayed
//

import SwiftUI

struct ContentView: View {
    //let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    @ObservedObject var order  = Order()
    @State private var isExpanded = false
    @State private var isSelected = 1

    var body: some View {
        
        NavigationView {
                
            VStack{
            menuTabbedView(selectedSegment: $isSelected)
               // TopBar(selected: $isSelected)
            
            if isSelected == 1{
                FoodMenuView(type: .food).environmentObject(order)
                    .animation(.spring())
            }else{
                FoodMenuView(type: .frozen).environmentObject(order).animation(.spring())
            }
            
            Spacer()
            }
                
            
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ImageOverlay: View {
    var text : String
    @Binding var isCollapsing:Bool

    var body: some View {
        ZStack {
            HStack{
                Image(systemName: "chevron.down")
                    .foregroundColor(.white)
                Spacer()
                Text(text)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(10)
            }.frame(width: 130, height: 50)
            
        } .padding()
        .background(Color(.black).opacity(0.7))
        .foregroundColor(.white)
        .cornerRadius(4)
        .onTapGesture {
            
            self.isCollapsing.toggle()
            
        }
        
        
    }
}

struct CustomHeader:View{
    
    let mainImage:String
    let sectionName:String
    @Binding var isExpading:Bool
    var body: some View{
        
        
        
        Image(mainImage)
            .resizable()
            
        .frame(width: .infinity, height: 200)
            .cornerRadius(10)
            .overlay(
                ImageOverlay(text:sectionName,isCollapsing:$isExpading),alignment:.topLeading)
        
        
    }
    
    
}
