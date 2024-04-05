#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import CombineCocoa

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
}

#endif
