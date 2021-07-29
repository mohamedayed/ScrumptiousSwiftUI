
//  Scrumptious APP
//
//  Created by mohamed ayed
//


import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    //@State private var loyaltyNumber = ""
   // @State private var tipAmount = 15
    @State private var showingPaymentAlert = false

    let paymentTypes = ["Cash", "Credit Card"]
  //  let tipAmounts = [10, 15, 20, 25, 0]


    var body: some View {
        Form {
            Section (footer:
                        Text(String(order.coponeValid))
                        .multilineTextAlignment(.center)
                        
                        .font(Font.headline.weight(.bold))
                        

                        .foregroundColor(order.coponeValid ? Color.green : Color.red )
            ){
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self) {
                        Text($0)
                    }
                }

                Toggle("Add Scrumptious Copone Code", isOn: $addLoyaltyDetails.animation())

                if addLoyaltyDetails {
                    TextField("Enter your Scrumptious ID", text: $order.coponeCodeText)
                        .keyboardType(.numberPad)
                }
            }

//            Section(header: Text("Add a tip?")) {
//                Picker("Percentage:", selection: $tipAmount) {
//                    ForEach(tipAmounts, id: \.self) {
//                        Text("\($0)%")
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//            }

            Section(header:
                        Text("TOTAL: \(order.totalPrice)")
                        .font(.largeTitle) 
            ) {
                Button("Confirm order") {
                    order.submitOrder(code: order.coponeCodeText)
                    showingPaymentAlert.toggle()
                    print("\(order.items)order.items")
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingPaymentAlert) {
            Alert(title: Text("Order confirmed"), message: Text("Your total was \(order.totalPrice)"), dismissButton: .default(Text("OK")))
            
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(Order())
    }
}
