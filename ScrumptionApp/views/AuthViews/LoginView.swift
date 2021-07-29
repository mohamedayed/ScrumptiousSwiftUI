//
//  LoginView.swift
//  ScrumptionApp
//
//  Created by mohamed ayed on 3/5/21.
//

import SwiftUI


struct LoginView: View {
    
    @EnvironmentObject private var formViewModel : FormRegViewModel

    var body: some View {
        VStack{
            
            
            HStack(spacing:15){
                
                Image(systemName: "envelope")
                    .foregroundColor(Color(hex:AppColors.primaryDark))
                    .font(.title2)
                TextField("email",text:$formViewModel.emailLogin)
                    .padding(.horizontal,10)
                
                
                
            }.TFModifier()
            
            
            
            HStack(spacing:15){
                
                Image(systemName: "lock")
                    .foregroundColor(Color(hex:AppColors.primaryDark))
                    .font(.title2)
                SecureField("Password",text:$formViewModel.passwordLogin)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal,10)
                
                
            }.TFModifier()
            
            
            
            
              Button(
                  action: {
                    
                    
                    let dict = [
                         "_identifier":"API",
                         "_type_params[type]":"login",
                         "_type_params[email]":formViewModel.emailLogin,
                         "_type_params[password]":formViewModel.passwordLogin
                         
                     
                     ] as [String : Any]
                     
                     formViewModel.loginUser(dict: dict)
                    
                    
                         
                      
                  },  label: {
                  
                    Text("Login")
                               .font(.headline)
                               .foregroundColor(.white)
                               .padding()
                               .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Capsule().fill(Color.themeColor))
                               
                       
                    
                    
                    
                  }).padding()
                 
                 
   
            Spacer(minLength: 0)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
