#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import CombineExt

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension Publisher where Output: Collection {
  public func mutateMany(
    _ mutation: @escaping (inout Output.Element) -> Void
  ) -> Publishers.Map<Self, [Output.Element]> {
    mapMany { output in
      var result = output
      mutation(&result)
      return result
    }
  }
}
#endif
