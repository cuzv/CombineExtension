#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import CombineExt
import Infrastructure

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension Publisher {
  func formResult() -> AnyPublisher<Result<Output, Failure>, Never> {
    materialize().compactMap { event -> Result<Output, Failure>? in
      switch event {
      case let .value(output):
        .success(output)
      case let .failure(error):
        .failure(error)
      case .finished:
        nil
      }
    }.eraseToAnyPublisher()
  }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension Publisher where Output: ResultConvertible, Failure == Never {
  func values() -> AnyPublisher<Output.Success, Never> {
    compactMap(\.result.success).eraseToAnyPublisher()
  }

  func failures() -> AnyPublisher<Output.Failure, Never> {
    compactMap(\.result.failure).eraseToAnyPublisher()
  }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension Publisher where Output: ResultConvertible, Failure == Output.Failure {
  func decouple() -> AnyPublisher<Output.Success, Output.Failure> {
    flatMapLatest { out in
      switch out.result {
      case let .success(value):
        Just<Output.Success>(value)
          .setFailureType(to: Output.Failure.self)
          .eraseToAnyPublisher()
      case let .failure(error):
        Fail<Output.Success, Failure>(error: error)
          .eraseToAnyPublisher()
      }
    }
    .eraseToAnyPublisher()
  }
}
#endif
