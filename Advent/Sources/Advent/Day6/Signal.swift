import Foundation

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
  
  var startOfMessageMarker: (String, Int) {
    var slidingWindow: (start: Int, end: Int) = (0,0)
    
    let dataStream = Array(raw)
    var output: (String, Int) = ("", 0)
    
    for i in 0..<dataStream.count {
      if slidingWindow.end - slidingWindow.start < 13 {
        slidingWindow.end += 1
      } else if slidingWindow.end - slidingWindow.start == 13 {
        var unique: Set<Character> = []
        
        for j in slidingWindow.start...slidingWindow.end {
          unique.insert(dataStream[j])
        }
        
        if unique.count == 14 {
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
