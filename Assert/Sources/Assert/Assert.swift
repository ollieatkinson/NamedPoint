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

public func ± <T>(lhs: T, rhs: T) -> (T, T) {
    (lhs, rhs)
}

extension Assert where T: Comparable & SignedNumeric {

    /// Example:
    ///   assert(double) ~= 5 ± 1 // <- asserts that double is between to 4 and 6
    public static func ~= (lhs: Assert<T>, rhs: (T, T)) {
        assert(lhs, rhs.0) { abs($0 - $1) <= rhs.1 }
    }
}

extension Assert where T: StringProtocol {

    public static func == (lhs: Assert<T>, rhs: T) {
       assert(lhs, rhs, ==)
    }

    public static func != (lhs: Assert<T>, rhs: T) {
        assert(lhs, rhs, !=)
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

private func assert<T>(_ a: Assert<T>, _ b: T, _ op: (T, T) -> Bool) where T: StringProtocol {
    let difference = descriptionOfDifference(
        between: a.value.seperatedByNewLine,
        and: b.seperatedByNewLine
    )
    XCTAssert(op(a.value, b), [ a.message, difference ].joined(separator: "\n"), file: a.file, line: a.line)
}

private func assertEqual<T>(_ a: Assert<T>, _ b: T) where T: Equatable {
}

fileprivate extension String {
    init<T>(dumping object: T) {
        self.init()
        dump(object, to: &self)
    }
}

@available(OSX 10.15, *)
extension CollectionDifference.Change {
    var offset: Int {
        switch self {
        case let .insert(offset, _, _), let .remove(offset, _, _):
            return offset
        }
    }
    
    var removeFirst: Int {
        switch self {
        case .insert:
            return 1
        case .remove:
            return 0
        }
    }
}

extension Collection {
    public func sorted<T>(by keyPath: KeyPath<Element, T>) -> [Element] where T: Comparable {
        sorted(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath]  })
    }
}

private func descriptionOfDifference<T>(between a: T, and b: T, printLineNumber: Bool = true) -> String
    where T: Equatable, T: BidirectionalCollection, T.Element: Hashable
{
    
    guard #available(OSX 10.15, *) else {
        if a != b {
            return "\(a) is not equal to \(b)"
        } else {
            return ""
        }
    }
    
    let difference = a.difference(from: b)
    
    guard difference.isEmpty == false else {
        return ""
    }
    
    func prefix(with offset: Int) -> String {
        printLineNumber ? "\(offset):\t" : ""
    }
    
    let string = difference.sorted(by: \.offset).sorted(by: \.removeFirst).map { diff -> String in
        switch diff {
        case let .insert(offset: offset, element: line, associatedWith: _):
            return prefix(with: offset).appending("got      \(line)")
        case let .remove(offset: offset, element: line, associatedWith: _):
            return prefix(with: offset).appending("expected \(line)")
        }
    }
    
    return """
    Found a difference:
    \(string.joined(separator: "\n"))
    """
}

extension StringProtocol {
    var seperatedByNewLine: [String] {
        components(separatedBy: "\n")
    }
}
