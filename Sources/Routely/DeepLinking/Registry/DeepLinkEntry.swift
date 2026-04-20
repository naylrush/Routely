//
// Copyright © 2025 Движ
//

import Foundation

public protocol DeepLinkEntryProtocol: Sendable {
    associatedtype DeepLinkType: DeepLink
    associatedtype DeepLinkHandler: DeepLinkHandling where DeepLinkHandler.DeepLinkType == DeepLinkType

    func parseDeepLink(rawDeepLink: RawDeepLink) throws -> DeepLinkType?
    func makeHandler() throws -> DeepLinkHandler
}

public struct DeepLinkEntry<
    RegexOutput: Sendable,
    DeepLinkType: DeepLink,
    DeepLinkHandler: DeepLinkHandling
>: DeepLinkEntryProtocol where DeepLinkHandler.DeepLinkType == DeepLinkType {
    public typealias DeepLinkBuilder = @Sendable (RegexOutput) throws -> DeepLinkType?
    public typealias HandlerBuilder = @Sendable () throws -> DeepLinkHandler

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

    public func parseDeepLink(rawDeepLink: RawDeepLink) throws -> DeepLinkType? {
        guard let output = try regex.wholeMatch(in: rawDeepLink.path)?.output,
              let deepLink = try deepLink(output) else { return nil }
        return deepLink
    }

    public func makeHandler() throws -> DeepLinkHandler {
        try handler()
    }
}

extension Regex: @retroactive @unchecked Sendable where RegexOutput: Sendable {}
