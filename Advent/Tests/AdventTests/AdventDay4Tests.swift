import Foundation
import XCTest

struct CampSection: Equatable {
  let bounds: ClosedRange<Int>
  
  func fullyContains(section: CampSection) -> Bool {
    return bounds.lowerBound <= section.bounds.lowerBound &&
    bounds.upperBound >= section.bounds.upperBound
  }
  
  func overlaps(with section: CampSection) -> Bool {
    return bounds.overlaps(section.bounds)
  }
  
  init(bounds: ClosedRange<Int>) {
    self.bounds = bounds
  }
  
  init?(boundsString: String) {
    let components = boundsString.components(separatedBy: "-")
    guard components.count == 2 else {
      return nil
    }
    
    guard let begin = Int(components[0]), let end = Int(components[1]), begin <= end else {
      return nil
    }
    
    self.bounds = begin...end
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
  
  func test_campSection_canBeInitializedFromString() {
    let sut = CampSection(boundsString: "2-8")
    let known = CampSection(bounds: 2...8)
    
    XCTAssertEqual(sut, known)
  }
  
  func test_campPlan_has936partialOverlappings() throws {
    var intersectionsCount = 0
    
    for (firstSection, secondSection) in try inputSections() {
      if firstSection.overlaps(with: secondSection) {
        intersectionsCount += 1
      }
    }
    
    XCTAssertEqual(intersectionsCount, 936)
  }
  
  func test_campPlan_has569SectionFullOverlappings() throws {
    var intersectionsCount = 0
    
    for (firstSection, secondSection) in try inputSections() {
      if firstSection.fullyContains(section: secondSection) || secondSection.fullyContains(section: firstSection) {
        intersectionsCount += 1
      }
    }
    
    XCTAssertEqual(intersectionsCount, 569)
  }
  
  private func inputSections() throws -> [(first: CampSection, second: CampSection)] {
    let input = TestBundle.inputData(for: 4)
    let itemRows = String(data: input, encoding: .utf8)!.components(separatedBy: "\n").filter{ !$0.isEmpty }
    
    var output: [(first: CampSection, second: CampSection)] = []
    for item in itemRows {
      let sectionStrings = item.components(separatedBy: ",")
      
      guard let firstSection = CampSection(boundsString: sectionStrings.first!),
            let secondSection = CampSection(boundsString: sectionStrings.last!) else {
        throw "Cannot create sections from input!"
      }
      
      output.append(
        (first: firstSection, second: secondSection)
      )
    }
    
    return output
  }
}

