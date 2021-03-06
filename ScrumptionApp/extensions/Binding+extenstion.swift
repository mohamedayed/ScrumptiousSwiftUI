
//  Scrumptious APP
//
//  Created by mohamed ayed
//


import Foundation
import SwiftUI
extension Binding {
    static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(get: { value }, set: { value = $0 })
    }
}
