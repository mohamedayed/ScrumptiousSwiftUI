
//  Scrumptious APP
//
//  Created by mohamed ayed
//


import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order

    var body: some View {
        
        NavigationView {
            
            
            List {
                
                
                
              
                    Section {
                        ForEach(order.items) { item in
                            HStack {
                                Text(item.itemqty)
                                    .foregroundColor(Color.white)
                                 .padding(10)
                                 .background(Color.themeColor)
                                 .clipShape(Rectangle())
                                 .cornerRadius(5)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                
                                
                                Text(item.item_title ?? "item name")
                                Spacer()
                                if let itemprice = item.item_price{
                                    Text("\(itemprice.clean) EGP")
                                }
                                
                               
                                    
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                        
                if order.items.count > 0{
                    
                        Text("TOTAL: \(order.totalPrice)")
                        .font(.largeTitle)
                        
                }
                

                    Section {
                        NavigationLink(destination: CheckoutView()) {
                            Text("Place Order")
                        }
                    }
                    .disabled(order.items.isEmpty)
                }
           
                .navigationTitle("Order")
                .listStyle(InsetGroupedListStyle())
                .toolbar {
                    EditButton()
            }
        }
           
           
     
    }

    func deleteItems(at offsets: IndexSet) {
        order.items.remove(atOffsets: offsets)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Order())
    }
}
