
import SwiftUI

@main
@available(iOS 17.0, *)
struct MyApp: App {
    @State private var sheetshown = true
    
    var body: some Scene {
        WindowGroup {
            ContentView(sheet: $sheetshown)
                .sheet(isPresented: $sheetshown, content: {
                    WelcomeView(opened: $sheetshown)
                })
        }
    }
}
