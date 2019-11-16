import XCTest

import lifeTests

var tests = [XCTestCaseEntry]()
tests += lifeTests.allTests()
XCTMain(tests)
