#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import CombineExt
import Infrastructure

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension Publisher {
  public func formTuple<Element>()
  -> Publishers.CompactMap<Publishers.Materialize<Self>, Tuple<[Element], Self.Failure?>>
  where [Element] == Output {
    materialize().compactMap { event -> Tuple<[Element], Failure?>? in
      switch event {
      case let .value(output):
        return .init(left: output, right: nil)
      case let .failure(error):
        return .init(left: [], right: error)
      case .finished:
        return nil
      }
    }
  }
}
#endif
