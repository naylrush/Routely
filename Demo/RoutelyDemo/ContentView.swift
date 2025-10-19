import SwiftUI
import Routely

struct ContentView: View {
    var body: some View {
        TabView {
            FlowRootView(initialRoute: FlowRoute.first)

            RootView(initialRoute: Route.root)
        }
    }
}

#Preview {
    ContentView()
}
