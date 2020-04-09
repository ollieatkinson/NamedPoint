import Assert

@testable import NamedPoint

final class NamedPointTests: XCTestCase {
    
    func test_anchor_top_left() {
        assert(NamedPoint.topLeft.anchor) == CGPoint(x: 0, y: 1)
    }
    
    func test_anchor_bottom_left() {
        assert(NamedPoint.topLeft.anchor) == CGPoint(x: 0, y: 1)
    }
    
}
