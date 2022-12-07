import Foundation
import XCTest
@testable import Advent

struct Signal {
  let raw: String
  
  var startOfPacketMarker: (String, Int) {
    var slidingWindow: (start: Int, end: Int) = (0,0)
    
    let dataStream = Array(raw)
    var output: (String, Int) = ("", 0)
    
    for i in 0..<dataStream.count {
      if slidingWindow.end - slidingWindow.start < 3 {
        slidingWindow.end += 1
      } else if slidingWindow.end - slidingWindow.start == 3 {
        var unique: Set<Character> = []
        
        for j in slidingWindow.start...slidingWindow.end {
          unique.insert(dataStream[j])
        }
        
        if unique.count == 4 {
          let markerChars = dataStream[slidingWindow.start...slidingWindow.end]
          output = (String(markerChars), i+1)
          break
        }
        
        slidingWindow.start += 1
        slidingWindow.end += 1
        
        if slidingWindow.end > dataStream.count - 1 {
          break
        }
      }
    }
    
    return output
  }
}

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
}

