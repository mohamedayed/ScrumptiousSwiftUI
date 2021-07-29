
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemRow: View {
    @State private var priceStepperValue:Double = 0.0
    
    let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]

    let item: FoodMenuItem

    var body: some View {
        
        HStack {
            WebImage(url:URL(string:item.thumbnailImage ))
                .resizable()
                .placeholder(Image("dish"))
                .indicator(Indicator {_,_ in
                    ProgressView()
                })
                .transition(.fade(duration: 0.5))
                .frame(width:50,height:50)
                
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.themeColor, lineWidth: 2).shadow(radius: 5))
            

            VStack(alignment: .leading) {
                Text(item.item_title ?? "Bitza")
                    
                Text("\(item.price?.clean ?? "EGP0") EGP")
            }

            
        
            
        
            Spacer()

//            ForEach(item.restrictions, id: \.self) { restriction in
//                Text(restriction)
//                    .font(.caption)
//                    .fontWeight(.black)
//                    .padding(5)
//                    .background(colors[restriction, default: .black])
//                    .clipShape(Circle())
//                    .foregroundColor(.white)
//            }
        }
        
    }
}
//
//struct ItemRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemRow(item: FoodMenuItem.example)
//    }
//}
