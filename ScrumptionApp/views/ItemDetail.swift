
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import SwiftUI
import SDWebImageSwiftUI
import Combine
struct ItemDetail: View {
    @EnvironmentObject var order: Order
    @State private var quantity:Int = 1
    @State private var showPopup:Bool = false
    @State private var toastTime  = 6
    var item_type:FoodType
    @State var item: FoodMenuItem
    
    @State private var itemTotalPrice:Double = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    


    var body: some View {
        
        GeometryReader{geo in
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                WebImage(url:URL(string:item.fullImage))
                    .resizable()
                    .frame(width:geo.size.width,height:geo.size.height/3)
                    
                    .scaledToFit()
                

                Text("\(item.item_title ?? "picture")")
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
            }

            Text(item.item_title ?? "Name")
                .padding(.top,10)
            
            HStack{
                
                Text("price")
                Spacer()
                Text(self.itemTotalPrice.clean)
                
            }.padding([.horizontal,.top],15)
            Divider()
               
                .background(Color.themeColor)
                .padding()
           
            VStack{
                
                if self.showPopup{
                    
                    
                    HStack{
                        Image(systemName: "cart.fill")
                            .resizable()
                            .frame(width:20,height: 20)
                            .foregroundColor(Color.white)
                        Text("Check your cart")
                            .foregroundColor(Color.white)
                            .fontWeight(.heavy)
                        
                        
                    }.padding([.horizontal,.top],15)
                    .padding(.bottom,30)
                    .background(Color.themeColor)
                    .clipShape(ArrowShape())
                }
                
                HStack{
                    
                    Button(action:{
                        
                        withAnimation{
                            
                            
                            if self.quantity > 1{
                                
                                self.quantity -= 1
                                if let itemprice = item.price{
                                    
                                
                                self.itemTotalPrice -= itemprice
                                }
                                
                            }
                        }
                        
                    }){
                        
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .frame(width:50,height:50)
                            .foregroundColor(Color.themeColor)
                           
                        
                    }
                    Spacer()
                    Text("\(self.quantity)")
                   Spacer()
                    
                    Button(action:{
                        withAnimation{
                            self.quantity += 1
                            if let itemprice = item.price{
                                
                            
                            self.itemTotalPrice += itemprice
                            }
                        }
                        
                        
                    }){
                        
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width:50,height:50)
                            .foregroundColor(Color.themeColor)
                           
                        
                        
                    }.frame(alignment:.trailing)
                    
                }
                
                
                .padding(10)
                
                
            }

            Divider()
               
                .background(Color.themeColor)
                .padding()
            
                Button(action:{
                    item.item_qty = self.quantity
                    
                    item.item_type  = item_type.rawValue
                    order.add(item: item)
                    withAnimation{
                        self.showPopup  = true
                    }
                }){
                    Text("Order This")
                        .font(.title2)
                        .padding(10)
                        .padding(.horizontal)
                        .background(Color.themeColor)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
           
                .disabled(self.showPopup)
                
            Spacer()
        }.onReceive(timer, perform: { _ in
                if self.toastTime > 0 {
                    self.toastTime -= 1
                }
                
            if self.toastTime == 0{
                self.showPopup = false
                self.toastTime = 6
            }
        })
        }.onAppear{
            if self.itemTotalPrice == 0.0{
                self.itemTotalPrice = item.price ?? 0.0
            }
            
        }
        
        .navigationTitle(item.item_title ?? "title")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemDetail(item_type: .food, item: FoodMenuItem.example)
                .environmentObject(Order())
        }
    }
}
