//
//  AuthView.swift
//  ScrumptionApp
//
//  Created by mohamed ayed on 3/5/21.
//

import SwiftUI



struct AuthView: View {
    
    @State private var selectedSegment = 0
    @Namespace var name

    @State private var prsentMain = false
    
   
    @ObservedObject private var formViewModel  = FormRegViewModel()
    
    
    var body: some View {
        
        NavigationView{
            
        
        VStack{
            VStack(){
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:70,height: 70)
                HStack{
                    Button(action:{
                        withAnimation(.spring()){
                            
                            selectedSegment = 0
                            
                            
                        }
                    }){
                        
                        VStack{
                            
                            
                            Text(StringConstants.Login)
                                .font(.system(size:20))
                                .foregroundColor((self.selectedSegment == 0) ? Color.black : Color.gray)
                            
                            
                            
                            ZStack{
                                Capsule()
                                    .fill(Color.black.opacity(0.1))
                                    
                                    .frame(height:4)
                                if selectedSegment == 0{
                                    
                                    Capsule()
                                        .fill(Color.black)
                                        .frame(height:4)
                                        .matchedGeometryEffect(id: "TAP", in: name)
                                    
                                    
                                    
                                }
                            }
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                    }
                    
                    Button(action:{
                        
                        withAnimation(.spring()){
                            
                            selectedSegment = 1
                            
                            
                        }
                    }){
                        
                        VStack{
                            Text(StringConstants.Register)
                                .font(.system(size:20))
                                .foregroundColor((self.selectedSegment == 1) ? Color.black : Color.gray)
                            ZStack{
                                Capsule()
                                    .fill(Color.black.opacity(0.1))
                                    
                                    .frame(height:4)
                                if selectedSegment == 1{
                                    
                                    Capsule()
                                        .fill(Color.black)
                                        .frame(height:4)
                                        .matchedGeometryEffect(id: "TAP", in: name)
                                    
                                    
                                    
                                }
                            }
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                    }
                }
                
                HStack {
                    Text(formViewModel.inlineErrorText)
                        .font(.caption2)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                    Spacer()
                }
                    
                
                
                
                
                
                
            }
           // .fullScreenCover(isPresented:$formViewModel.IsLoggedIn,content:MainView.init)
            
            .fullScreenCover(isPresented: $formViewModel.IsLoggedIn, content: MainView.init)

            
            .padding(.top,30)
           
            
            
            
//            NavigationLink(
//                destination: MainView(),
//                isActive: $formViewModel.IsLoggedIn){
//                    EmptyView()
//                }
//
            
         
                if selectedSegment == 1{
                    RegisterationView().animation(.spring())
                }else{
                    LoginView().animation(.spring())
                }
               
            
            
          
        }.environmentObject(formViewModel)
        .navigationBarHidden(true)
        
        
       
            
            
        }
        .statusBar(hidden: true)
      
        
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
