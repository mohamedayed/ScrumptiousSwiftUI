
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import Foundation
import SwiftUI
struct ActivityIndicatorView: View {
    @Binding var isPresented:Bool
    var body: some View {
        if isPresented{
            ZStack{
                RoundedRectangle(cornerRadius: 15).fill(Color.black.opacity(0.1))
                ProgressView {
                    Text("Loading...")
                        .font(.title2)
                }
            }.frame(width: 120, height: 120, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 25).stroke(Color.black,lineWidth: 2))
        }
    }
}
