import SwiftUI
import Routely

struct ContentView: View {
    var body: some View {
        TabView {
            RootView(initialRoute: Route.stackDemo)
                .tabItem { Label("Stack", systemImage: "square.stack") }

            RootView(initialRoute: Route.creationDemo)
                .tabItem { Label("Creation", systemImage: "plus.circle") }

            FlowRootView(initialRoute: FlowRoute.first)
                .tabItem { Label("Flow", systemImage: "arrow.right.circle") }
        }
    }
}

#Preview {
    ContentView()
}
