import Foundation
import XCTest
@testable import Advent

struct Signal {
  let raw: String
  
  var startOfPacketMarker: String {
    var slidingWindow: (start: Int, end: Int) = (0,0)
    
    let dataStream = Array(raw)
    
    for char in dataStream {
      if slidingWindow.end - slidingWindow.start < 4 {
        slidingWindow.end += 1
      } else {
        
        var unique: Set<Character> = []
        
        for i in slidingWindow.start...slidingWindow.end {
          unique.insert(dataStream[i])
        }
        
        if unique.count == 4 {
          return dataStream[slidingWindow.start...slidingWindow.end]
        }
        
        slidingWindow.start += 1
        slidingWindow.end += 1
      }
      
      
    }
    
    return String(dataStream.suffix(2))
  }
}

final class AdventDay6Tests: XCTestCase {
  func test_signal_knowsStartOfPacketMarker() {
    let sut = Signal(dataStream: "12134")
    
    XCTAssertEqual(sut.startOfPacketMarker, "2134")
  }
}

