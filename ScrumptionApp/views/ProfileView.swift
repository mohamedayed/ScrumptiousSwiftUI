
//  Scrumptious APP
//
//  Created by mohamed ayed
//


import SwiftUI

struct ProfileView: View {
    
    @ObservedObject private var profileVM = ProfileVM()
    @EnvironmentObject private var formVM : FormRegViewModel
    @State private var showingBranchDialog:Bool = false
    @State private var branchSelectedId:Int = 0
    var body: some View {
    
            VStack{
                
                Image(systemName:"person")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
                    .background(Color.themeColor)
                    .clipShape(Circle())
                Text("Update Profile")
                    .foregroundColor(Color.themeColor)
                    .font(.title3)
                    .fontWeight(.bold)
                Capsule()
                    .fill(Color.themeColor)
                    .frame(width:200, height:2)
                
                
                ScrollView(.vertical,showsIndicators:false){
                    
                    HStack(spacing:15){
                        
                        Image(systemName: "person")
                            .foregroundColor(Color.themeColor)
                            .font(.title2)
                        TextField(profileVM.profileUsername,text:$profileVM.profileUsername)
                            .padding(.horizontal,10)
                        
                        
                        
                    }.TFModifier()
                    
                    
                    HStack(spacing:15){
                        
                        Image(systemName: "envelope")
                            .foregroundColor(Color.themeColor)
                            .font(.title2)
                        TextField("email",text:$profileVM.profileEmail)
                            .padding(.horizontal,10)
                        
                        
                        
                    }.TFModifier()
                    
                    
                    
                    HStack(spacing:15){
                        
                        Image(systemName: "phone")
                            .foregroundColor(Color.themeColor)
                            .font(.title2)
                        TextField(profileVM.profilePhoneNumber,text:$profileVM.profilePhoneNumber)
                            .padding(.horizontal,10)
                        
                        
                        
                    }.TFModifier()
                    
                    
                    
                    
                    HStack(spacing:15){
                        
                        Image(systemName: "building.2")
                            .foregroundColor(Color.themeColor)
                            .font(.title2)
                        TextField(profileVM.profileCompany,text:$profileVM.profileCompany)
                            .padding(.horizontal,10)
                        
                        
                        
                    }.TFModifier()
                    .disabled(true)
                    
                    
                    
                    if(!profileVM.profileCompanyBranch.isEmpty){
                        
                        
                            HStack(spacing:15){
                                Image(systemName: "building.2")
                                    .foregroundColor(Color(hex:AppColors.primaryDark))
                                    .font(.title2)
                                Spacer()
                                Text(profileVM.profileCompanyBranch)
                                    .padding(.horizontal,10)
                                Image(systemName:"chevron.right")
                            }.TFModifier()
                            
                            // Making actionsheet Company
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                self.showingBranchDialog = true
                                formVM.getBranchesList(agentID: profileVM.profileCompanyID)
                                
                                
                            }.actionSheet(isPresented: self.$showingBranchDialog, content: {
                                var buttons: [ActionSheet.Button] = formVM.branchList.map {item in
                                    ActionSheet.Button.default(
                                        Text(item.name).font(.title2).foregroundColor(Color(.black))
                                    ) {
                                        if(formVM.branchList.count == 0){
                                            
                                            self.profileVM.profileCompanyBranch = ""
                                        }else{
                                            
                                            self.profileVM.profileCompanyBranch = item.name
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
                            .foregroundColor(Color.themeColor)
                            .font(.title2)
                        TextField(profileVM.profileDeskLocation,text:$profileVM.profileDeskLocation)
                            .padding(.horizontal,10)
                        
                        
                        
                    }.TFModifier()
                    
                    
                    
                    HStack(spacing:15){
                        
                        Image(systemName: "lock")
                            .foregroundColor(Color(hex:AppColors.primaryDark))
                            .font(.title2)
                        TextField(profileVM.profilePassword,text:$profileVM.profilePassword)
                            .padding(.horizontal,10)
                        
                        
                        
                    }.TFModifier()
                    
                    
                    
                    HStack(spacing:15){
                        
                        Image(systemName: "lock")
                            .foregroundColor(Color.themeColor)
                            .font(.title2)
                        SecureField(profileVM.profilePasswordAgain,text:$profileVM.profilePasswordAgain)
                            .padding(.horizontal,10)
                        
                        
                        
                    }.TFModifier()
                    
                    
                    HStack {
                        Button(action:{
                         
                            let dict = [
                                 "_identifier":"API",
                                 "_type_params[type]":"updateProfile",
                                 "_type_params[username]":profileVM.profileUsername,
                                 "_type_params[agent]":profileVM.profileCompanyID,
                                 "_type_params[branch]":branchSelectedId,
                                 "_type_params[email]":profileVM.profileEmail,
                                 "_type_params[password]":profileVM.profilePassword,
                                 "token":formVM.ApiToken
                                 
                             
                             ] as [String : Any]
                             
                             profileVM.updateUser(dict: dict)
                      
                                  
                            
                            
                        }){
                            Text("Save")
                                .font(.title2)
                                .padding(10)
                                .padding(.horizontal)
                                .background(Color.themeColor)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                            
                            
                        }
                        
                        
                        Button(action:{
                          
                     
                            formVM.logout()
                            
                        }){
                            Text("Logout")
                                .font(.title2)
                                .padding(10)
                                .padding(.horizontal)
                                .background(Color.themeColor)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                            
                            
                        }
                    }
                    
                    
                    
                    
                }
                
              
                Spacer(minLength: 0)
            }.padding(.horizontal)
            
            
        
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
