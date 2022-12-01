import XCTest
import Foundation
@testable import Advent

final class AdventDay1Tests: XCTestCase {
  func test_mostCaloriesCarries65thElf_andAmountIs70698() throws {
    let sut = try XCTUnwrap(ElvesGroup.init(from: TestBundle.inputData(for: 1)))
    //Elf count is 1 bigger than 0-based index
    XCTAssertEqual(sut.topCarrier.index + 1, 65)
    XCTAssertEqual(sut.topCarrier.load, 70698)
  }
  
  func test_topThreeLoadedElves_haveLoadOf206643() throws {
    let sut = try XCTUnwrap(ElvesGroup.init(from: TestBundle.inputData(for: 1)))
    
    XCTAssertEqual(sut.topThreeCarriersLoad, 206643)
  }
}
