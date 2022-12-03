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
    let itemsCount = itemsString.count
    self.firstCompartment = .init(itemsString: String(itemsString.prefix(itemsCount/2)))
    self.secondCompartment = .init(itemsString: String(itemsString.suffix(itemsCount/2)))
  }
  
  var duplicate: Character {
    let firstItems = Set(firstCompartment.items)
    let secondItems = Set(secondCompartment.items)
    let duplicates = firstItems.intersection(secondItems)
    return duplicates.first!
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
    
  func test_rucksack_splitsTheItemsStringInHalf_duringInitialization() {
    let itemsString = "abcDEF"
    let sut = Rucksack(itemsString: itemsString)
    XCTAssertEqual(sut.firstCompartment.items.count, itemsString.count / 2)
    XCTAssertEqual(sut.firstCompartment.items, ["a", "b", "c"])
    XCTAssertEqual(sut.secondCompartment.items.count, itemsString.count / 2)
    XCTAssertEqual(sut.secondCompartment.items, ["D", "E", "F"])
  }
  
  func test_rucksack_knowsWhichItemIsPresent_inBothCompartments() {
    let itemsString = "abcDbF"
    let sut = Rucksack(itemsString: itemsString)
    XCTAssertEqual(sut.duplicate, "b")
  }
  
  func test_item_canBeConverted_intoPriority() {
    let a: Character = "a"
    XCTAssertEqual(a.priority, 1)
    let b: Character = "b"
    XCTAssertEqual(b.priority, 2)
    let z: Character = "z"
    XCTAssertEqual(z.priority, 26)
    let A: Character = "A"
    XCTAssertEqual(A.priority, 27)
    let Z: Character = "Z"
    XCTAssertEqual(Z.priority, 52)
  }
}

extension Character {
  var priority: Int {
    switch self {
    case "a"..."z":
      return Int(self.asciiValue!) - 96
    case "A"..."Z":
      return Int(self.asciiValue!) - 38
    default:
      return -1
    }
  }
}
