#if canImport(Combine)
import Combine
import Foundation

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension FileManager {
    func read(name: String, in directory: SearchPathDirectory) -> AnyPublisher<Data, Error> {
        .single { promise in
            do {
                let documentsURL = try self.url(
                    for: .applicationSupportDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil,
                    create: true
                )

                let fileURL = documentsURL.appendingPathComponent(name)
                promise(.success(try Data(contentsOf: fileURL)))
            } catch {
                promise(.failure(error))
            }
            return {}
        }
    }

    func write(data: Data, name: String, in directory: SearchPathDirectory) -> AnyPublisher<URL, Error> {
        .single { promise in
            do {
                let documentsURL = try self.url(
                    for: .applicationSupportDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil,
                    create: true
                )

                let url = documentsURL.appendingPathComponent(name)
                try data.write(to: url, options: .atomic)

                promise(.success(url))
            } catch {
                promise(.failure(error))
            }
            return {}
        }
    }
}
#endif
