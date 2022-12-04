import Foundation

struct CampSection: Equatable {
  let bounds: ClosedRange<Int>
  
  func fullyContains(section: CampSection) -> Bool {
    return bounds.lowerBound <= section.bounds.lowerBound &&
    bounds.upperBound >= section.bounds.upperBound
  }
  
  func overlaps(with section: CampSection) -> Bool {
    return bounds.overlaps(section.bounds)
  }
  
  init(bounds: ClosedRange<Int>) {
    self.bounds = bounds
  }
  
  init?(boundsString: String) {
    let components = boundsString.components(separatedBy: "-")
    guard components.count == 2 else {
      return nil
    }
    
    guard let begin = Int(components[0]), let end = Int(components[1]), begin <= end else {
      return nil
    }
    
    self.bounds = begin...end
  }
}
