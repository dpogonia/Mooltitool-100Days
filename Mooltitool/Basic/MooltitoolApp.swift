
import SwiftUI

@main
struct MooltitoolApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            InitialView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

