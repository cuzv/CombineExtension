import Foundation
import Dispatch
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public typealias TimeStride = DispatchQueue.SchedulerTimeType.Stride

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public typealias Current<Output> = CurrentValueSubject<Output, Never>

public enum CombineExtensions {
}

public protocol CombineExtensionsProvider {}

extension CombineExtensionsProvider {
    /// A proxy which hosts reactive extensions for `self`.
    public var combine: Combine<Self> {
        return Combine(self)
    }

    /// A proxy which hosts static reactive extensions for the type of `self`.
    public static var combine: Combine<Self>.Type {
        return Combine<Self>.self
    }
}

/// A proxy which hosts reactive extensions of `Base`.
public struct Combine<Base> {
    /// The `Base` instance the extensions would be invoked with.
    public let base: Base

    /// Construct a proxy
    ///
    /// - parameters:
    ///   - base: The object to be proxied.
    fileprivate init(_ base: Base) {
        self.base = base
    }
}

extension NSObject: CombineExtensionsProvider {}
