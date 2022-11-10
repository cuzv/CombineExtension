#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import CombineExt
import Infrastructure

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension Publisher {
  public func formResult() -> AnyPublisher<Result<Output, Failure>, Never> {
    materialize().compactMap { event -> Result<Output, Failure>? in
      switch event {
      case let .value(output):
        return .success(output)
      case let .failure(error):
        return .failure(error)
      case .finished:
        return nil
      }
    }.eraseToAnyPublisher()
  }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension Publisher where Output: ResultConvertible, Failure == Never {
  public func values() -> AnyPublisher<Output.Success, Never> {
    compactMap(\.result.success).eraseToAnyPublisher()
  }

  public func failures() -> AnyPublisher<Output.Failure, Never> {
    compactMap(\.result.failure).eraseToAnyPublisher()
  }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension Publisher where Output: ResultConvertible, Failure == Output.Failure {
  public func decouple() -> AnyPublisher<Output.Success, Output.Failure> {
    flatMapLatest { out in
      switch out.result {
      case let .success(value):
        return Just(value)
          .setFailureType(to: Output.Failure.self)
          .eraseToAnyPublisher()
      case let .failure(error):
        return Fail(error: error)
          .eraseToAnyPublisher()
      }
    }
    .eraseToAnyPublisher()
  }
}
#endif
