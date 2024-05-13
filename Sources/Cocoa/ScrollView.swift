#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import CombineCocoa
import UIKit

public extension UIScrollView {
  func loadMorePublisher(offset: CGFloat = 0) -> AnyPublisher<Void, Never> {
    contentOffsetPublisher
      .map { [weak self] contentOffset -> Bool in
        guard let self else { return false }
        guard contentSize.height > 0 else { return false }
        let visibleHeight = frame.height - contentInset.top - contentInset.bottom
        let threshold = contentOffset.y + visibleHeight + offset
        let hit = threshold > contentSize.height
        return hit
      }
      .removeDuplicates()
      .filter { $0 }
      .map { _ in () }
      .eraseToAnyPublisher()
  }

  var shouldScrollToTopPublisher: AnyPublisher<Bool, Never> {
    let selector = #selector(UIScrollViewDelegate.scrollViewShouldScrollToTop(_:))
    return delegateProxy.interceptSelectorPublisher(selector)
      .map { $0[1] as! Bool }
      .eraseToAnyPublisher()
  }
}

#endif
