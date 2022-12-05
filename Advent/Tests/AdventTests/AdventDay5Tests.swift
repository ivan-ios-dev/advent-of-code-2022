import Foundation
import XCTest

  struct MoveCommand {
    let amount: Int
    let fromStackIndex: Int
    let toStackIndex: Int
    
    init?(command: String) {
      let parts = command.components(separatedBy: .letters).filter{ !$0.isEmpty }.map{ $0.replacingOccurrences(of: " ", with: "") }
      guard parts.count == 3 else {
        return nil
      }
      self.amount = Int(parts[0])!
      self.fromStackIndex = Int(parts[1])!
      self.toStackIndex = Int(parts[2])!
    }
class CrateStack {
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

final class AdventDay5Tests: XCTestCase {
  func test_moveCommand_canBeInitializedFromString() {
    let sut = CargoCrane.MoveCommand(command: "move 1 from 2 to 1")
    XCTAssertEqual(sut?.amount, 1)
    XCTAssertEqual(sut?.fromStackIndex, 2)
    XCTAssertEqual(sut?.toStackIndex, 1)
  }
  func test_crateStack_hasIndex() {
    let sut = CrateStack(index: 0)
    XCTAssertEqual(sut.index, 0)
  }
  
  func test_crateStack_canAcceptCrates() {
    let sut = CrateStack(index: 1)
    sut.add(crate: "Z")
    XCTAssertEqual(sut.crates.count, 1)
  }
  
  func test_crateStack_canRemoveTopCrate() {
    let sut = CrateStack(crates: ["A", "B", "C"], index: 1)
    let removedCrate = sut.takeCrate()
    XCTAssertEqual(sut.crates.count, 2)
    XCTAssertEqual(removedCrate, "C")
    XCTAssertEqual(sut.topCrate, "B")
  }
}
