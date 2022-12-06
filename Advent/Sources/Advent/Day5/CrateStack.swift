import Foundation

final class CrateStack: Equatable {
  static func == (lhs: CrateStack, rhs: CrateStack) -> Bool {
    return lhs.index == rhs.index && lhs.crates == rhs.crates
  }
  
  var crates: [Character]
  let index: Int
  
  init(crates: [Character] = [], index: Int) {
    self.crates = crates
    self.index = index
  }
  
  var topCrate: Character? {
    crates.last
  }
  
  func add(crate: Character) {
    crates.append(crate)
  }
  
  func takeCrate() -> Character? {
    crates.popLast()
  }
}
