import XCTest
@testable import ParkourDatasource

final class ParkourDatasourceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ParkourDatasource().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
