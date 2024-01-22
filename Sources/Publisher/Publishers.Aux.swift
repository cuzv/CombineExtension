#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import CombineExt
import Infra

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension Publisher {
  func withFlatMapLatest<P: Publisher>(
    _ transform: @escaping (Output) -> P
  ) -> AnyPublisher<(Output, P.Output), Failure> where P.Failure == Failure {
    flatMapLatest {
      transform($0).with($0).reverse()
    }.eraseToAnyPublisher()
  }

  func withFlatMap<P: Publisher>(
    _ transform: @escaping (Output) -> P
  ) -> AnyPublisher<(Output, P.Output), Failure> where P.Failure == Failure {
    flatMap {
      transform($0).with($0).reverse()
    }.eraseToAnyPublisher()
  }
}

// MARK: -

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension AnyPublisher {
  static func materialize<Input>(
    _ transform: @escaping (Input) -> AnyPublisher<Output, Failure>
  ) -> (Input) -> AnyPublisher<CombineExt.Event<Output, Failure>, Never> {
    {
      transform($0).materialize().eraseToAnyPublisher()
    }
  }

  static func witMaterialize<Input>(
    _ transform: @escaping (Input) -> AnyPublisher<Output, Failure>
  ) -> (Input) -> AnyPublisher<CombineExt.Event<(Input, Output), Failure>, Never> {
    {
      transform($0).with($0).reverse().materialize().eraseToAnyPublisher()
    }
  }

  static func formResult<Input>(
    _ transform: @escaping (Input) -> AnyPublisher<Output, Failure>
  ) -> (Input) -> AnyPublisher<Result<Output, Failure>, Never> {
    {
      transform($0).formResult()
    }
  }

  static func withFormResult<Input>(
    _ transform: @escaping (Input) -> AnyPublisher<Output, Failure>
  ) -> (Input) -> AnyPublisher<Result<(Input, Output), Failure>, Never> {
    {
      transform($0).with($0).reverse().formResult()
    }
  }
}
#endif
