import XCTest
import Foundation
@testable import Advent

struct Rucksack {
  struct Compartment {
    let items: [Character]
    
    init(itemsString: String) {
      self.items = Array(itemsString)
    }
  }
  
  let firstCompartment: Compartment
  let secondCompartment: Compartment
}

final class AdventDay3Tests: XCTestCase {

  
  func test_compartment_canBeInitialized_fromEmptyString() {
    let sut = Rucksack.Compartment(itemsString: "")
    XCTAssertEqual(sut.items.count, 0)
  }
  
  func test_compartment_canBeInitialized_fromItemsString() {
    let sut = Rucksack.Compartment(itemsString: "vJrwpWtwJgWr")
    XCTAssertEqual(sut.items.count, 12)
  }
  
}

