#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import Infrastructure

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension Publisher {
  public func dropNils<Wrapped>()
  -> Publishers.CompactMap<Self, Wrapped>
  where Output == Wrapped? {
    compactMap { $0 ?? nil }
  }

  public func with<Inserted: AnyObject>(
    _ inserted: Inserted
  ) -> Publishers.CompactMap<Self, (Output, Inserted)> {
    compactMap { [weak inserted] value in
      if let inserted = inserted {
        return (value, inserted)
      }
      return nil
    }
  }

  public func succeeding<Successor: AnyObject>(
    _ successor: Successor
  ) -> Publishers.CompactMap<Self, Successor> {
    compactMap { [weak successor] _ in
      successor
    }
  }
}

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
