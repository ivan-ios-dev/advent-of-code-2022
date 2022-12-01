import XCTest
import Foundation
@testable import Advent

struct Elf {
  let itemsCalories: [Int]
  var totalCalories: Int {
    return itemsCalories.reduce(0, +)
  }
}

struct ElvesGroup {
  let elves: [Elf]
    
  var topCarrierIndex: Int {
    return 0
  }
  
  var topCarrierLoad: Int {
    return 0
  }
}

final class AdventDay1Tests: XCTestCase {
  func test_mostCaloriesCarriesNthElf_andAmountIsX() {
    let sut = ElvesGroup(elves: [])
    
    XCTAssertEqual(sut.topCarrierIndex, -1)
    XCTAssertEqual(sut.topCarrierLoad, -1)
  }
}
