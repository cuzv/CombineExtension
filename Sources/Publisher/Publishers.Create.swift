#if canImport(Combine)
import Combine
import CombineExt

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension AnyPublisher {
  public static func single(
    _ factory: @escaping (@escaping (Swift.Result<Output, Failure>) -> Void) -> () -> Void
  ) -> AnyPublisher<Output, Failure> {
    return .create { subscriber in
      return AnyCancellable(factory { result in
        switch result {
        case let .success(output):
          subscriber.send(output)
          subscriber.send(completion: .finished)
        case let .failure(error):
          subscriber.send(completion: .failure(error))
        }
      })
    }
  }
}
#endif
