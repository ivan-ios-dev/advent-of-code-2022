import XCTest
import Foundation
@testable import Advent

final class AdventDay3Tests: XCTestCase {
  
  func test_allRucksacks_fromInput() throws {
    let input = TestBundle.inputData(for: 3)
    let itemRows = String(data: input, encoding: .utf8)!.components(separatedBy: "\n").filter{ !$0.isEmpty }
    
    var prioritiesSum = 0
    
    for row in itemRows {
      let rucksack = Rucksack(itemsString: row)
      prioritiesSum += rucksack.duplicate.priority
    }
    
    XCTAssertEqual(prioritiesSum, 8039)
  }
  
  func test_allSafetyGroups_returnsSummedPriority() {
    let input = TestBundle.inputData(for: 3)
    let itemRows = String(data: input, encoding: .utf8)!.components(separatedBy: "\n").filter{ !$0.isEmpty }
    
    var totalPriority = 0
    
    for i in stride(from: 0, to: itemRows.count - 1, by: 3) {
      let first = Rucksack(itemsString: itemRows[i])
      let second = Rucksack(itemsString: itemRows[i+1])
      let third = Rucksack(itemsString: itemRows[i+2])
      
      let group = ElvesSafetyGroupBelongings(first: first, second: second, third: third)
      totalPriority += group.badgeItem.priority
    }
    
    XCTAssertEqual(totalPriority, 2510)
  }
  
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
  
  func test_elvesSafetyGroupBelongings_knowsBadgeItem() {
    let sut = ElvesSafetyGroupBelongings(
      first: .init(itemsString: "vJrwpWtwJgWrhcsFMMfFFhFp"),
      second: .init(itemsString: "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL"),
      third: .init(itemsString: "PmmdzqPrVvPwwTWBwg")
    )
    XCTAssertEqual(sut.badgeItem, "r")
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
