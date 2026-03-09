import Routely
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RootView(initialRoute: Route.stackDemo)
                .tabItem { Label("Stack", systemImage: "square.stack") }

            RootView(initialRoute: Route.creationDemo)
                .tabItem { Label("Creation", systemImage: "plus.circle") }

            RootView(initialRoute: Route.resultsDemo)
                .tabItem { Label("Results", systemImage: "checkmark.circle") }

            FlowRootView(initialRoute: FlowRoute.first)
                .tabItem { Label("Flow", systemImage: "arrow.right.circle") }
        }
    }
}

#Preview {
    ContentView()
}
