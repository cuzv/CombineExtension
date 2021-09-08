#if canImport(Combine)
import Foundation
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension Publishers {
  public final class ActivityIndicator {
    public let isLoading: AnyPublisher<Bool, Never>

    private let lock = NSRecursiveLock()
    private let relay = CurrentValueSubject<Int, Never>(0)

    public init() {
      isLoading = relay
        .map({ $0 > 0 })
        .removeDuplicates()
        .share(replay: 1)
        .eraseToAnyPublisher()
    }

    private func increment() {
      lock.lock()
      relay.value += 1
      lock.unlock()
    }

    private func decrement() {
      lock.lock()
      relay.value -= 1
      lock.unlock()
    }

    fileprivate func trackActivityOfPublisher<Source: Publisher>(
      source: Source
    ) -> AnyPublisher<Source.Output, Source.Failure> {
      source.handleEvents(receiveCompletion: { _ in
        self.decrement()
      }, receiveCancel: {
        self.decrement()
      }, receiveRequest: { _ in
        self.increment()
      })
      .eraseToAnyPublisher()
    }
  }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension Publisher {
  public func trackActivity(
    _ activityIndicator: Publishers.ActivityIndicator
  ) -> AnyPublisher<Output, Failure> {
    activityIndicator.trackActivityOfPublisher(source: self)
  }
}
#endif
