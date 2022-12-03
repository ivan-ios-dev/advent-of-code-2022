import XCTest
import Foundation
@testable import Advent

final class AdventDay2Tests: XCTestCase {
  func test_gameInitializedFromInput_has2500_rounds() throws {
    let sut = try XCTUnwrap(Game.init(data: TestBundle.inputData(for: 2)))
    XCTAssertEqual(sut.rounds.count, 2500)
  }
  
  func test_gameInitializedFromInput_givesYou_Nscore() throws {
    let sut = try XCTUnwrap(Game.init(data: TestBundle.inputData(for: 2)))
    XCTAssertEqual(sut.score, 12382)

  }
  
  func test_gameRound_fromXandA_returnsLost_withScoreEquals3() {
    let sut = GameRound(myLetter: "X", rivalLetter: "A")
    XCTAssertEqual(sut.outcome, .lost)
    XCTAssertEqual(sut.myScore, 3)
  }
  
  func test_gameRound_fromY_andA_returnsDraw_withScoreEquals4() {
    let sut = GameRound(myLetter: "Y", rivalLetter: "A")
    XCTAssertEqual(sut.outcome, .draw)
    XCTAssertEqual(sut.myScore, 4)
  }
}
