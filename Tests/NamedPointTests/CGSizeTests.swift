import Assert

@testable import NamedPoint

final class CGSizeTests: XCTestCase {
    
    let screen = CGRect(size: .init(width: 3440, height: 1440))
    let square = CGSize(square: 200)

    func test_aligned_bottom_left() {
        assert(square.rect(aligned: .bottom(.left), inside: screen)) == CGRect(origin: .zero, size: square)
    }
    
    func test_aligned_left_middle() {
        assert(square.rect(aligned: .left(.middle), inside: screen)) == CGRect(origin: .init(x: .zero, y: screen.height / 2 - square.height / 2), size: square)
    }
    
    func test_aligned_top_left() {
        assert(square.rect(aligned: .top(.left), inside: screen)) == CGRect(origin: .init(x: .zero, y: screen.height - square.height), size: square)
    }
    
    func test_aligned_top_center() {
        assert(square.rect(aligned: .top(.center), inside: screen)) == CGRect(origin: .init(x: screen.width / 2 - square.width / 2, y: screen.height - square.height), size: square)
    }
    
    func test_aligned_top_right() {
        assert(square.rect(aligned: .top(.right), inside: screen)) == CGRect(origin: .init(x: screen.width - square.width, y: screen.height - square.height), size: square)
    }
    
    func test_aligned_right_middle() {
        assert(square.rect(aligned: .right(.middle), inside: screen)) == CGRect(origin: .init(x: screen.width - square.width, y: screen.height / 2 - square.height / 2), size: square)
    }
    
    func test_aligned_bottom_right() {
        assert(square.rect(aligned: .bottom(.right), inside: screen)) == CGRect(origin: .init(x: screen.width - square.width, y: .zero), size: square)
    }
    
    func test_aligned_bottom_center() {
        assert(square.rect(aligned: .bottom(.center), inside: screen)) == CGRect(origin: .init(x: screen.width / 2 - square.width / 2, y: .zero), size: square)
    }
    
    func test_aspect_fit() {
        assert(AspectRatio(width: 16, height: 9).aspectFit(inside: screen)) == CGRect(x: 440, y: 0, width: 2560, height: 1440)
    }
    
}
