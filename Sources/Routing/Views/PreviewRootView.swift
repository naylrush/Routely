////
//// Copyright © 2025 Движ
////
//
//import RoutingInterfaces
//import SwiftUI
//
//public struct PreviewRootView<Route: RouteProtocol, Content: View>: View {
//    private let content: Content
//
//    public init(@ViewBuilder content: () -> Content) {
//        self.content = content()
//    }
//
//    public var body: some View {
//        RootView(destination: DescribingDestination) {
//            content
//        }
//    }
//
//    private func DescribingDestination(_ route: Route) -> some View {
//        Text(String(describing: route))
//    }
//}
//
//@MainActor
//public enum PreviewRootViewBuilder<Route: RouteProtocol> {
//    static func make(content: () -> some View) -> some View {
//        PreviewRootView<Route, _>(content: content)
//    }
//}
