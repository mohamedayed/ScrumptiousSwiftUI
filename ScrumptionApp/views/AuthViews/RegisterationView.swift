//
//  RegisterationView.swift
//  ScrumptionApp
//
//  Created by mohamed ayed on 2/26/21.
//

import SwiftUI
import Combine
import PopupView

struct RegisterationView: View {
    
    @State private var selectedSegment = 0
    @Namespace var name
    
    @EnvironmentObject  var formViewModel : FormRegViewModel
    @State private var showingBranchDialog = false
    @State private var selection = 0
    @State var showingPopup = false
    @State private var branchSelectedId = 0
    @State private var companySelectedId = 0
    @State private var companySelectedName = ""
    @State private var branchSelectedName = ""
    @State private var showingCompanyDialog = false
   
    
    var body: some View {
        
        VStack{
       
            
            
            
        
        ScrollView(.vertical,showsIndicators:false){
            
            HStack(spacing:15){
                
                Image(systemName: "person")
                    .foregroundColor(Color(hex:AppColors.primaryDark))
                    .font(.title2)
                TextField("Username",text:$formViewModel.username)
                    .padding(.horizontal,10)
                
                
                
            }.TFModifier()
            
            
            
            HStack(spacing:15){
                
                Image(systemName: "envelope")
                    .foregroundColor(Color(hex:AppColors.primaryDark))
                    .font(.title2)
                TextField("Email address",text:$formViewModel.emailAddress)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal,10)
                
                
            }.TFModifier()
            
            
            
            HStack(spacing:15){
                
               
                Image(systemName: "phone")
                    .foregroundColor(Color(hex:AppColors.primaryDark))
                    .font(.title2)
                TextField("Phone Number",text:$formViewModel.phoneNumber)
                    .keyboardType(.numberPad)
                    .padding(.horizontal,10)
                
                
                
            }.TFModifier()
            
            
            
            
            HStack(spacing:15){
                Image(systemName: "building.2")
                    .foregroundColor(Color(hex:AppColors.primaryDark))
                    .font(.title2)
                Spacer()
                Text(companySelectedName)
                    .padding(.horizontal,10)
                Image(systemName:"chevron.right")
                
                
            }.TFModifier()
            
            // Making actionsheet Company
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                self.showingCompanyDialog = true
                
                
            }.actionSheet(isPresented: self.$showingCompanyDialog, content: {
                var buttons: [ActionSheet.Button] = formViewModel.companyList.map {item in
                    ActionSheet.Button.default(
                        Text(item.code).font(.title2).foregroundColor(Color(.black))
                        
                        
                        
                        
                        
                    ) {
                        
                        self.companySelectedName = item.code
                        self.companySelectedId = item.id
                        
                       
                        formViewModel.getBranchesList(agentID: item.id)
                        //Start fetching desk
                        
                        
                    }
                }
                buttons.append(.cancel())
                
                return ActionSheet(title: Text("What is Your Company"), buttons: buttons)
            })
            
            
            
            
            
            
            if(formViewModel.showingBranchDialog){
                HStack(spacing:15){
                    Image(systemName: "building.2")
                        .foregroundColor(Color(hex:AppColors.primaryDark))
                        .font(.title2)
                    Spacer()
                    Text(self.branchSelectedName)
                        .padding(.horizontal,10)
                    Image(systemName:"chevron.right")
                }.TFModifier()
                
                // Making actionsheet Company
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    self.showingBranchDialog = true
                    
                    
                }.actionSheet(isPresented: self.$showingBranchDialog, content: {
                    var buttons: [ActionSheet.Button] = formViewModel.branchList.map {item in
                        ActionSheet.Button.default(
                            Text(item.name).font(.title2).foregroundColor(Color(.black))
                        ) {
                            if(formViewModel.branchList.count == 0){
                                
                                self.branchSelectedName = ""
                            }else{
                                
                                self.branchSelectedName = item.name
                                self.branchSelectedId = item.id
                                
                            }
                        }
                    }
                    buttons.append(.cancel())
                    
                    return ActionSheet(title: Text("Which Branch"), buttons: buttons)
                })
                
                
                
                
            }
            
            
            
            HStack(spacing:15){
                
                
                Image(systemName: "studentdesk")
                    .foregroundColor(Color(hex:AppColors.primaryDark))
                    .font(.title2)
                TextField("Desk Location",text:$formViewModel.deskLocation)
                    
                    .padding(.horizontal,10)
                
                
                
            }.TFModifier()
            
            
            
            
            HStack(spacing:15){
                
                
                Image(systemName: "lock")
                    .foregroundColor(Color(hex:AppColors.primaryDark))
                    .font(.title2)
                SecureField("Password",text:$formViewModel.password)
                   
                    .padding(.horizontal,10)
                
                
                
            }.TFModifier()
            
            
            HStack(spacing:15){
                
                
                Image(systemName: "lock")
                    .foregroundColor(Color(hex:AppColors.primaryDark))
                    .font(.title2)
                SecureField("Confirm Password",text:$formViewModel.passwordAgain)
                    
                    .padding(.horizontal,10)
                
                
                
            }.TFModifier()

            
              Button(
                  action: {
                    
                   let dict = [
                        "_identifier":"API",
                        "_type_params[type]":"signup",
                        "_type_params[fullname]":formViewModel.username,
                        "_type_params[agent]":companySelectedId,
                        "_type_params[branch]":branchSelectedId,
                        "_type_params[email]":formViewModel.emailAddress,
                        "_type_params[password]":formViewModel.password
                        
                    
                    ] as [String : Any]
                    
                    formViewModel.registerUser(dict: dict)
             
                         
                    
                    
                    
                    
                      
                  },  label: {
                    
                      Text("Register")
                                 .font(.headline)
                                 .foregroundColor(.white)
                                 .padding()
                                 .frame(minWidth: 0, maxWidth: .infinity)
                          .background(Capsule().fill(Color.themeColor))
                                 
                      
                  }).padding()
                 
                  .disabled(!formViewModel.isValid)
                 
   
            
            //end button
            
            
            
            
        }.padding(.top,30)
        .onAppear{
            if(!formViewModel.CompanyListDone){
                formViewModel.getCompaniesList()
            }
            
            
        }.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
        
        
        
        
        
        
        
        
        Spacer(minLength: 0)
        
    }
//        .popup(isPresented: $showingPopup, autohideIn: 2) {
//            HStack {
//                Text("The popup")
//            }
//            .frame(width: 200, height: 60)
//            .background(Color(red: 0.85, green: 0.8, blue: 0.95))
//            .cornerRadius(30.0)
//        }
//
        
    }
}

struct RegisterationView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterationView()
    }
}

