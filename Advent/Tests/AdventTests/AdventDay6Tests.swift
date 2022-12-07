import Foundation
import XCTest
@testable import Advent

final class AdventDay6Tests: XCTestCase {
  func test_signal_knowsStartOfPacketMarker() {
    let s1 = Signal(raw: "12134")
    let (marker1, count1) = s1.startOfPacketMarker
    XCTAssertEqual(marker1, "2134")
    XCTAssertEqual(count1, 5)
    
    let s2 = Signal(raw: "mjqjpqmgbljsphdztnvjfqwrcgsmlb")
    let (marker2, count2) = s2.startOfPacketMarker
    XCTAssertEqual(marker2, "jpqm")
    XCTAssertEqual(count2, 7)
  }
  
  func test_signal_knowsStartOfPacketMarker_fromInput() throws {
    let input = TestBundle.inputData(for: 6)
    let inputString = try XCTUnwrap(String(data: input, encoding: .utf8))
    
    let sut = Signal(raw: inputString)
    let (marker, count) = sut.startOfPacketMarker
    
    XCTAssertEqual(marker, "tjlm")
    XCTAssertEqual(count, 1542)
  }
  
  func test_signal_knowsStartOfMessageMarker() throws {
    let inputString = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
    
    let sut = Signal(raw: inputString)
    let (marker, count) = sut.startOfMessageMarker
    
    XCTAssertEqual(marker, "qmgbljsphdztnv")
    XCTAssertEqual(count, 19)
  }
  
  func test_signal_knowsStartOfMessageMarker_fromInput() throws {
    let input = TestBundle.inputData(for: 6)
    let inputString = try XCTUnwrap(String(data: input, encoding: .utf8))
    
    let sut = Signal(raw: inputString)
    let (marker, count) = sut.startOfMessageMarker
    
    XCTAssertEqual(marker, "trjcwsmpgflhdq")
    XCTAssertEqual(count, 3153)
  }
}

