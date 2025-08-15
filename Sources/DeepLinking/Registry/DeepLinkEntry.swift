//
// Copyright © 2025 Движ
//

import Foundation
import RoutingInterfaces

public protocol DeepLinkEntryProtocol: Actor {
    associatedtype DeepLink: DeepLinkProtocol
    associatedtype DeepLinkHandler: Handler where DeepLinkHandler.DeepLink == DeepLink

    func parseDeepLink(rawDeepLink: RawDeepLink) async throws -> DeepLink?
    func makeHandler() async throws -> DeepLinkHandler
}

public actor DeepLinkEntry<
    RegexOutput,
    DeepLink: DeepLinkProtocol,
    DeepLinkHandler: Handler
>: DeepLinkEntryProtocol where DeepLinkHandler.DeepLink == DeepLink {
    public typealias DeepLinkBuilder = @Sendable (RegexOutput) throws -> DeepLink?
    public typealias HandlerBuilder = @Sendable @MainActor () throws -> DeepLinkHandler

    private let regex: Regex<RegexOutput>
    private let deepLink: DeepLinkBuilder
    private let handler: HandlerBuilder

    public init(
        _ regex: Regex<RegexOutput>,
        deepLink: @escaping DeepLinkBuilder,
        handler: @escaping HandlerBuilder
    ) {
        self.regex = regex
        self.deepLink = deepLink
        self.handler = handler
    }

    public func parseDeepLink(rawDeepLink: RawDeepLink) async throws -> DeepLink? {
        guard let output = try regex.wholeMatch(in: rawDeepLink.path)?.output,
              let deepLink = try deepLink(output) else { return nil }
        return deepLink
    }

    public func makeHandler() async throws -> DeepLinkHandler {
        try await handler()
    }
}
