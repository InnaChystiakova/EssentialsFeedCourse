//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Inna Chystiakova on 02/09/2024.
//

import XCTest
import EssentialFeed

class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) {_, _, error in
            if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
class URLSessionHTTPClientTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    // MARK: - Helpers
    
    private class URLProtocolStub: URLProtocol {
        private static var stubs = [URL: Stub]()
        
        private struct Stub {
            let error: Error?
        }
                
        static func stub(url: URL, error: Error? = nil) {
            stubs[url] = Stub(error: error)
        }
        
        static func startInterceptingRequests() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        
        static func stopInterceptingRequests() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            stubs = [:]
        }
        
        override class func canInit(with request: URLRequest) -> Bool {
            guard let url = request.url else {
                return false
            }
            
            return URLProtocolStub.stubs[url] != nil
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {
            guard let url = request.url, let stub = URLProtocolStub.stubs[url] else {
                return
            }
            
            if let error = stub.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        }
        
        override func stopLoading() { }
    }
        
    //MARK: - Tests
        
    func testGetFromURLFailsOnRequestError() {
        URLProtocolStub.startInterceptingRequests()
        
        let url = URL(string: "https://any-url.com")!
        let error = NSError(domain: "domain error", code: 1)
        
        URLProtocolStub.stub(url: url, error: error)
        
        let sut = URLSessionHTTPClient()
        
        let exp = expectation(description: "Wait for completion")
        sut.get(from: url) { result in
            switch result {
            case let .failure(receivedError as NSError):
                XCTAssertEqual(receivedError.domain, error.domain)
                XCTAssertEqual(receivedError.code, error.code)
            default:
                XCTFail("Expected failure with error \(error), got \(result) instead")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        URLProtocolStub.stopInterceptingRequests()
    }
}
