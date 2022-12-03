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
  
  init(itemsString: String) {
    self.firstCompartment = .init(itemsString: String(itemsString.prefix(12)))
    self.secondCompartment = .init(itemsString: String(itemsString.suffix(12)))
  }
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
  
  func test_rucksack_canBeInitialized_fromEmptyItemsString() {
    let sut = Rucksack(itemsString: "")
    XCTAssertEqual(sut.firstCompartment.items.count, 0)
    XCTAssertEqual(sut.secondCompartment.items.count, 0)
  }
  
  func test_rucksack_canBeInitialized_fromItemsString() {
    let sut = Rucksack(itemsString: "vJrwpWtwJgWrhcsFMMfFFhFp")
    XCTAssertEqual(sut.firstCompartment.items.count, 12)
    XCTAssertEqual(sut.secondCompartment.items.count, 12)
  }
}

