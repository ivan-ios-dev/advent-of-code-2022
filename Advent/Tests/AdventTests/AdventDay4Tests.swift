import Foundation
import XCTest

struct CampSection: Equatable {
  let bounds: ClosedRange<Int>
  
  func fullyContains(section: CampSection) -> Bool {
    return bounds.first! <= section.bounds.first! &&
           bounds.last! >= section.bounds.last!
  }
}

final class AdventDay4Tests: XCTestCase {
  
  
  func test_campSections_areEqual_whenBoundsAreTheSame() {
    let s1 = CampSection(bounds: 1...2)
    let s2 = CampSection(bounds: 1...2)
    
    XCTAssertEqual(s1, s2)
  }
  
  func test_campSection_containsSmallerSection() {
    let bigger = CampSection(bounds: 2...8)
    let smaller = CampSection(bounds: 3...7)
    
    XCTAssertTrue(bigger.fullyContains(section: smaller))
    XCTAssertFalse(smaller.fullyContains(section: bigger))
    XCTAssertTrue(smaller.fullyContains(section: smaller))
  }
}
