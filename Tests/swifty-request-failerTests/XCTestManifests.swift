import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(swifty_request_failerTests.allTests),
    ]
}
#endif
