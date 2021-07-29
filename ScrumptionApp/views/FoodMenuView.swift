
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import SwiftUI

struct FoodMenuView: View {
    @EnvironmentObject var order:Order
    var type:FoodType
    var body: some View {
        List {
            if let foodMenuListdata = order.foodMenuList,!foodMenuListdata.isEmpty{
            
                ForEach(foodMenuListdata) { section in
                    Section(header:
                                Text(section.title ?? "menu section")
                                .font(.headline)
                                .fontWeight(.heavy)
                    
                    
//                                CustomHeader(mainImage: section.items[0].thumbnailImage,sectionName: section.name,isExpading: $isExpanded)
                                
                    
                    ) {
                        
                        if let foodMenuListItemData = section.items{
                        ForEach(foodMenuListItemData) { item in
//                            if isExpanded{
                                
                                 
                            NavigationLink(destination: ItemDetail(item_type:type, item: item)) {
                            if let itemcatid = item.item_category,let cat_id = section.cat_id {
                                if String(cat_id) == itemcatid{
                                    ItemRow(item: item)
                                }
                            }
                            
                            
                                

                                        }
                                     
                                        
                                    
                               
                            }
                        
//                            .transition(.move(edge:.bottom))
//                            .animation(.easeInOut(duration: 20))
//
                        
                        
                    }
                                

                    //        }
                  
                    }
                }
            
        }
            
            else{
                HStack
                {
                    Spacer()
                    ProgressView()
                        .padding()
                    Spacer()

                    
                }
                    
                
            }
            
            
            }
        .onAppear{
            
            order.getHomeFoodMenu(type: type)
        }
       
        .navigationTitle(type.rawValue)
        .listStyle(InsetGroupedListStyle())
    }
}

struct FoodMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FoodMenuView(type: .food).environmentObject(Order())
    }
}
