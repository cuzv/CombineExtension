#if canImport(Combine)
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension Publisher {
  public func ignore(
    _ isExcluded: @escaping (Output) -> Bool
  ) -> Publishers.Filter<Self> {
    filter({ !isExcluded($0) })
  }

  public func tryIgnore(
    _ isExcluded: @escaping (Output) throws -> Bool
  ) -> Publishers.TryFilter<Self> {
    tryFilter({ try !isExcluded($0) })
  }

  public func filter(
    _ isIncluded: Output...
  ) -> Publishers.Filter<Self> where Output: Equatable {
    filter({ isIncluded.contains($0) })
  }

  public func ignore(
    _ isExcluded: Output...
  ) -> Publishers.Filter<Self> where Output: Equatable {
    filter({ !isExcluded.contains($0) })
  }

  public func filter(
    _ isExcludedA: @escaping (Output) -> Bool,
    _ isExcludedB: @escaping (Output) -> Bool
  ) -> Publishers.Filter<Self> {
    filter(isExcludedA)
      .filter(isExcludedB)
  }

  public func filter(
    _ isExcludedA: @escaping (Output) -> Bool,
    _ isExcludedB: @escaping (Output) -> Bool,
    _ isExcludedC: @escaping (Output) -> Bool
  ) -> Publishers.Filter<Self> {
    filter(isExcludedA)
      .filter(isExcludedB)
      .filter(isExcludedC)
  }

  public func ignore(
    _ isExcludedA: @escaping (Output) -> Bool,
    _ isExcludedB: @escaping (Output) -> Bool
  ) -> Publishers.Filter<Self> {
    filter({ !isExcludedA($0) })
      .filter({ !isExcludedB($0) })
  }

  public func ignore(
    _ isExcludedA: @escaping (Output) -> Bool,
    _ isExcludedB: @escaping (Output) -> Bool,
    _ isExcludedC: @escaping (Output) -> Bool
  ) -> Publishers.Filter<Self> {
    filter({ !isExcludedA($0) })
      .filter({ !isExcludedB($0) })
      .filter({ !isExcludedC($0) })
  }
}
#endif
