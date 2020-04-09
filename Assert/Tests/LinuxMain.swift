import XCTest

import AssertTests

var tests = [XCTestCaseEntry]()
tests += AssertTests.allTests()
XCTMain(tests)
