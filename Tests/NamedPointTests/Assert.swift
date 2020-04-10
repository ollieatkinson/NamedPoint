//
//  Assert.swift
//
//
//  Created by Oliver Atkinson on 19/03/2020.
//

@_exported import XCTest

public struct Assert<T> {
    let value: T
    let message: String
    let function: String
    let file: StaticString
    let line: UInt
}

public func assert<T>(_ this: @autoclosure () throws -> Any, as: T.Type = T.self, message: @autoclosure () -> String = "", function: String = #function, file: StaticString = #file, line: UInt = #line) rethrows -> Assert<T> {
    return Assert(value: try this() as! T, message: message(), function: function, file: file, line: line)
}

public func assert<T>(_ this: @autoclosure () throws -> T, message: @autoclosure () -> String = "", function: String = #function, file: StaticString = #file, line: UInt = #line) rethrows -> Assert<T> {
    return Assert(value: try this(), message: message(), function: function, file: file, line: line)
}

public func assert<T>(throws this: @autoclosure () throws -> T, message: @autoclosure () -> String = "", function: String = #function, file: StaticString = #file, line: UInt = #line, handle: (Error) -> Void = {_ in}) {
    XCTAssertThrowsError(try this(), message(), file: file, line: line, handle)
}

public func assert<T>(doesNotThrow this: @autoclosure () throws -> T, message: @autoclosure () -> String = "", function: String = #function, file: StaticString = #file, line: UInt = #line) {
    XCTAssertNoThrow(try this(), message(), file: file, line: line)
}

public func fail(_ error: @autoclosure () -> Error, function: String = #function, file: StaticString = #file, line: UInt = #line) {
    XCTFail("\(error())", file: file, line: line)
}

public func fail(_ because: @autoclosure () -> String = "", function: String = #function, file: StaticString = #file, line: UInt = #line) {
    XCTFail(because(), file: file, line: line)
}

extension Assert where T: Equatable {
    
    public static func == (lhs: Assert<T>, rhs: T) {
        XCTAssertEqual(lhs.value, rhs, lhs.message, file: lhs.file, line: lhs.line)
    }

    public static func != (lhs: Assert<T>, rhs: T) {
        XCTAssertNotEqual(lhs.value, rhs, lhs.message, file: lhs.file, line: lhs.line)
    }
    
}

extension Assert where T: Comparable {

    public static func < (lhs: Assert<T>, rhs: T) {
        assert(lhs, rhs, <)
    }

    public static func <= (lhs: Assert<T>, rhs: T) {
        assert(lhs, rhs, <=)
    }

    public static func > (lhs: Assert<T>, rhs: T) {
        assert(lhs, rhs, >)
    }

    public static func >= (lhs: Assert<T>, rhs: T) {
        assert(lhs, rhs, >=)
    }
    
}

infix operator ± : NilCoalescingPrecedence

public func ± <T>(lhs: T, rhs: T) -> (T, T) { (lhs, rhs) }

extension Assert where T: Comparable & SignedNumeric {

    /// Example:
    ///   assert(double) ~= 5 ± 1 // <- asserts that double is between to 4 and 6
    public static func ~= (lhs: Assert<T>, rhs: (T, T)) {
        assert(lhs, rhs.0) { abs($0 - $1) <= rhs.1 }
    }
}

public protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { self }
}

extension Assert where T: OptionalType {
    
    public func isNil() {
        XCTAssertNil(value.optional, message, file: file, line: line)
    }
    
    public func isNotNil() {
        XCTAssertNotNil(value.optional, message, file: file, line: line)
    }
    
}

private func assert<T>(_ a: Assert<T>, _ b: T, _ op: (T, T) -> Bool) {
    XCTAssert(op(a.value, b), a.message, file: a.file, line: a.line)
}
