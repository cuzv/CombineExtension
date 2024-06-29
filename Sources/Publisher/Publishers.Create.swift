#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import CombineExt

@available(*, unavailable, message: "`CombineExt.AnyPublisher.create` method is buggy when use followed with `.subscribe(on: backgroundQueue)` inside/outside of `flatMapLatest`")
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension AnyPublisher {
  static func _single_(
    _ factory: @escaping (@escaping (Swift.Result<Output, Failure>) -> Void) -> () -> Void
  ) -> AnyPublisher<Output, Failure> {
    .create { subscriber in
      AnyCancellable(factory { result in
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
