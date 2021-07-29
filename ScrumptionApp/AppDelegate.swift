
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import Foundation
import UIKit
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
  
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .red

        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.monospacedSystemFont(ofSize: 36, weight: .black)
        ]

        appearance.largeTitleTextAttributes = attrs

        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
//
//
//        UITabBar.appearance().backgroundColor = UIColor(named: "tabBackgroundColor")
//        UITabBar.appearance().barTintColor = UIColor(named: "tabBackgroundColor")
//        UITabBarAppearance().selectionIndicatorTintColor = UIColor(named: "themeColor")
//        UITabBar.appearance().tintColor = UIColor(named:"themeColor")
//
        
        return false
    }
}
