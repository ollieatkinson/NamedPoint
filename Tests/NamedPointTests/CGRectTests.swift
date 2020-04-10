import XCTest

@testable import NamedPoint

final class CGRectTests: XCTestCase {
    
    let screen = CGRect(size: .init(width: 3440, height: 1440))
    let square = CGSize(square: 200)

    func test_aligned_bottom_left_inside() {
        assert(CGRect(aligned: .bottom(.left), inside: screen, size: square)) == CGRect(origin: screen.origin, size: square)
    }
    
    func test_aligned_left_middle_inside() {
        assert(CGRect(aligned: .left(.middle), inside: screen, size: square)) == CGRect(origin: .init(x: .zero, y: screen.height / 2 - square.height / 2) + screen.origin, size: square)
    }
    
    func test_aligned_top_left_inside() {
        assert(CGRect(aligned: .top(.left), inside: screen, size: square)) == CGRect(origin: .init(x: .zero, y: screen.height - square.height) + screen.origin, size: square)
    }
    
    func test_aligned_top_center_inside() {
        assert(CGRect(aligned: .top(.center), inside: screen, size: square)) == CGRect(origin: .init(x: screen.width / 2 - square.width / 2, y: screen.height - square.height) + screen.origin, size: square)
    }
    
    func test_aligned_top_right_inside() {
        assert(CGRect(aligned: .top(.right), inside: screen, size: square)) == CGRect(origin: .init(x: screen.width - square.width, y: screen.height - square.height) + screen.origin, size: square)
    }
    
    func test_aligned_right_middle_inside() {
        assert(CGRect(aligned: .right(.middle), inside: screen, size: square)) == CGRect(origin: .init(x: screen.width - square.width, y: screen.height / 2 - square.height / 2) + screen.origin, size: square)
    }
    
    func test_aligned_bottom_right_inside() {
        assert(CGRect(aligned: .bottom(.right), inside: screen, size: square)) == CGRect(origin: .init(x: screen.width - square.width, y: .zero) + screen.origin, size: square)
    }
    
    func test_aligned_bottom_center_inside() {
        assert(CGRect(aligned: .bottom(.center), inside: screen, size: square)) == CGRect(origin: .init(x: screen.width / 2 - square.width / 2, y: .zero) + screen.origin, size: square)
    }
    
    func test_aligned_bottom_left_outside() {
        assert(CGRect(aligned: .bottom(.left), outside: screen, size: square)) == CGRect(origin: .init(x: .zero, y: -square.height) + screen.origin, size: square)
    }
    
    func test_aligned_left_middle_outside() {
        assert(CGRect(aligned: .left(.middle), outside: screen, size: square)) == CGRect(origin: .init(x: -square.width, y: screen.height / 2 - square.height / 2) + screen.origin, size: square)
    }
    
    func test_aligned_top_left_outside() {
        assert(CGRect(aligned: .top(.left), outside: screen, size: square)) == CGRect(origin: .init(x: .zero, y: screen.height) + screen.origin, size: square)
    }
    
    func test_aligned_top_center_outside() {
        assert(CGRect(aligned: .top(.center), outside: screen, size: square)) == CGRect(origin: .init(x: screen.width / 2 - square.width / 2, y: screen.height) + screen.origin, size: square)
    }
    
    func test_aligned_top_right_outside() {
        assert(CGRect(aligned: .top(.right), outside: screen, size: square)) == CGRect(origin: .init(x: screen.width - square.width, y: screen.height) + screen.origin, size: square)
    }
    
    func test_aligned_right_middle_outside() {
        assert(CGRect(aligned: .right(.middle), outside: screen, size: square)) == CGRect(origin: .init(x: screen.width, y: screen.height / 2 - square.height / 2) + screen.origin, size: square)
    }
    
    func test_aligned_bottom_right_outside() {
        assert(CGRect(aligned: .bottom(.right), outside: screen, size: square)) == CGRect(origin: .init(x: screen.width - square.width, y: -square.height) + screen.origin, size: square)
    }
    
    func test_aligned_bottom_center_outside() {
        assert(CGRect(aligned: .bottom(.center), outside: screen, size: square)) == CGRect(origin: .init(x: screen.width / 2 - square.width / 2, y: -square.height) + screen.origin, size: square)
    }
    
}
