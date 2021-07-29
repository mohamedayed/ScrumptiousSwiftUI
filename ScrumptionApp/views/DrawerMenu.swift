
//  Scrumptious APP
//
//  Created by mohamed ayed
//


import SwiftUI
struct DrawerMenu:View{
    @Binding var showMenu:Bool
    @Binding var darkMode:Bool
    @EnvironmentObject private var formViewModel : FormRegViewModel
    @State private var MenuItemSelected:Int? = nil
    var body:some View{
        
        
        
            VStack{
                VStack{
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            withAnimation{
                                self.showMenu.toggle()
                            }
                            
                        }) {
                            
                            Image(systemName:"xmark").resizable().frame(width: 15, height: 15).padding()
                                .foregroundColor(.white)
                            
                        }
                        
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                    }.padding(.horizontal)
                    .padding(.top)
                    
                    Image(systemName:"person")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(Color.themeColor)
                        .clipShape(Circle())
                    
                    Text("Amro Ewes")
                    Text("Hive")
                    
                    
                }
                .frame(width:UIScreen.main.bounds.width / 1.5)
                
                .background(Color.white)
                Spacer()
                
             
                
                ScrollView ([.vertical],showsIndicators:false){
                    ForEach(0..<6){ menuItem in
                        Button(action:{
                            
                            self.MenuItemSelected = menuItem
                            
                            
                                
                            
                        }){
                            
                            NavigationLink(destination:ProfileView(),tag:4,selection:self.$MenuItemSelected){
                                HStack(){
                                    Image(helpers.MenuData()[menuItem].icon).resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color.themeColor)
                                    Text(helpers.MenuData()[menuItem].title)
                                        .font(.title3)
                                        .frame(maxWidth:.infinity,alignment:.leading)
                                        
                                        .foregroundColor(Color.themeColor)
                                        .background(Color(.black))
                                    
                                    
                                    
                                    
                                }
                                .padding(5)
                                .background(Color(.black))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
                                
                                
                            }.isDetailLink(false)
                            
                      
                            
                        }.padding(.top,10)
                        
                    }
                }
                
                
                
                Spacer()
                
                
                Spacer()
                
                
            }
            .foregroundColor(.primary)
            .padding(.horizontal,20)
            .frame(width: UIScreen.main.bounds.width / 1.5)
            .background(Color(.black))
            //.background(self.darkMode ? Color.black:Color.white)
            
            //        .background(
            //            Image(self.darkMode ?  "books_bg" : "lib-bg")
            //                .resizable(resizingMode:.tile)
            //
            //                  .edgesIgnoringSafeArea(.all)
            //                .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height)
            //          )
            
            .edgesIgnoringSafeArea(.all)
            .overlay(Rectangle().stroke(Color.primary.opacity(0.2),lineWidth: 2).shadow(radius: 3 )  .edgesIgnoringSafeArea(.all))
        
        
        
        
        
    }
    
    
}
struct DrawerMenu_Previews: PreviewProvider {
    static var previews: some View {
        DrawerMenu(showMenu: .constant(true), darkMode: .constant(true))
    }
}
