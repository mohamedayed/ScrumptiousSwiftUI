
//  Scrumptious APP
//
//  Created by mohamed ayed
//


import SwiftUI

@main
struct ScrumptionAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var formviewModel = FormRegViewModel()
    var body: some Scene {
        
        WindowGroup {
            if !formviewModel.IsLoggedIn{
                AuthView()
                    .environmentObject(formviewModel)
                
            }else{
                MainView().environmentObject(formviewModel)
                
            }
            
            
            
        }
    }
}
