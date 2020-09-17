import XCTest

import ProductHuntTests

var tests = [XCTestCaseEntry]()
#if canImport(UIKit)
tests += ProductHuntTests.allTests()
#endif
XCTMain(tests)
