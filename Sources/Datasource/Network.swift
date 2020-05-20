import Foundation
import Dispatch

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

let PROJECT_URL = "https://github.com/OpenParkingApp"

// MARK: - Generic

public func get(url: URL,
                headers: [String: String]? = nil,
                session: URLSession = .shared,
                completion: @escaping (Result<(Data, HTTPURLResponse), OpenParkingError>) -> Void) {
    var request = URLRequest.openParkingRequest(toURL: url)
    request.add(headers: headers ?? [:])
    send(request: request, session: session, completion: completion)
}

public func get(url: URL,
                headers: [String: String]? = nil,
                session: URLSession = .shared) throws -> (Data, HTTPURLResponse) {
    let semaphore = DispatchSemaphore(value: 0)

    var result: Result<(Data, HTTPURLResponse), OpenParkingError>? = nil
    get(url: url, headers: headers, session: session) { res in
        result = res
        semaphore.signal()
    }

    semaphore.wait()

    switch result! {
    case .failure(let error):
        throw error
    case .success(let response):
        return response
    }
}

public func post(url: URL,
                 headers: [String: String]? = nil,
                 body: Data?,
                 session: URLSession = .shared,
                 completion: @escaping (Result<(Data, HTTPURLResponse), OpenParkingError>) -> Void) {
    var request = URLRequest.openParkingRequest(toURL: url)
    request.httpMethod = "POST"
    request.add(headers: headers ?? [:])
    request.httpBody = body
    send(request: request, session: session, completion: completion)
}

public func post(url: URL,
                 headers: [String: String]? = nil,
                 body: Data?,
                 session: URLSession = .shared) throws -> (Data, HTTPURLResponse) {
    let semaphore = DispatchSemaphore(value: 0)

    var result: Result<(Data, HTTPURLResponse), OpenParkingError>? = nil
    post(url: url, headers: headers, body: body, session: session) { res in
        result = res
        semaphore.signal()
    }

    semaphore.wait()

    switch result! {
    case .failure(let error):
        throw error
    case .success(let response):
        return response
    }
}

// MARK: - Internal

private func send(request: URLRequest,
                  session: URLSession,
                  completion: @escaping (Result<(Data, HTTPURLResponse), OpenParkingError>) -> Void) {
    let task = session.dataTask(with: request) { data, response, error in
        guard let data = data,
            let response = response as? HTTPURLResponse,
            error == nil else {
                completion(.failure(.network(error!)))
                return
        }
        completion(.success((data, response)))
    }

    task.resume()
}

private extension URLRequest {
    static func openParkingRequest(toURL url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("OpenParking-\(PROJECT_URL)", forHTTPHeaderField: "User-Agent")
        return request
    }

    mutating func add(headers: [String: String]) {
        for (key, value) in headers {
            self.addValue(value, forHTTPHeaderField: key)
        }
    }
}
