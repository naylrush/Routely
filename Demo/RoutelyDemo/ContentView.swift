import SwiftUI
import Routely

struct ContentView: View {
    var body: some View {
        FlowRootView(initialRoute: FlowRoute.first)
    }
}

#Preview {
    ContentView()
}
