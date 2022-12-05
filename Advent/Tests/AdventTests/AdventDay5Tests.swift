import Foundation
import XCTest

final class CargoCrane {
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
  }
  
  let cargoField: [CrateStack]
  
  init(cargoField: [CrateStack]) {
    self.cargoField = cargoField
  }
  
  func perform(command: MoveCommand) {
    if let sourceStack = cargoField.first(where: { $0.index == command.fromStackIndex } ),
        let destinationStack = cargoField.first(where: { $0.index == command.toStackIndex }) {
      
      for _ in 1...command.amount {
        if let crate = sourceStack.takeCrate() {
          destinationStack.add(crate: crate)
        }
      }
    }
  }
}

final class CrateStack {
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
  
  func test_cargoField_canBeInitialized_fromInputString() throws {
    let inputString = """
                [J] [Z] [G]
                [Z] [T] [S] [P] [R]
    [R]         [Q] [V] [B] [G] [J]
    [W] [W]     [N] [L] [V] [W] [C]
    [F] [Q]     [T] [G] [C] [T] [T] [W]
    [H] [D] [W] [W] [H] [T] [R] [M] [B]
    [T] [G] [T] [R] [B] [P] [B] [G] [G]
    [S] [S] [B] [D] [F] [L] [Z] [N] [L]
     1   2   3   4   5   6   7   8   9
    """
    
    let rows = inputString.components(separatedBy: "\n")
    
    for row in rows {
      //Crates
      if row.contains("[") {
        
        
        
      } else { //Crate Index
        
      }
    }
    
    XCTAssertEqual(rows.count, 9)
  }
  
  func test_moveCommand_canBeInitializedFromString() {
    let sut = CargoCrane.MoveCommand(command: "move 1 from 2 to 1")
    XCTAssertEqual(sut?.amount, 1)
    XCTAssertEqual(sut?.fromStackIndex, 2)
    XCTAssertEqual(sut?.toStackIndex, 1)
  }
  
  func test_cargoCrane_performsMoveCommand() throws {
    let sut = CargoCrane(cargoField: [
      .init(crates: ["Z", "N"], index: 1),
      .init(crates: ["M", "C", "D"], index: 2)
    ])
    
    let command = try XCTUnwrap(CargoCrane.MoveCommand(command: "move 1 from 2 to 1"))
    sut.perform(command: command)
    XCTAssertEqual(sut.cargoField[0].crates, ["Z", "N", "D"])
    XCTAssertEqual(sut.cargoField[1].crates, ["M", "C"])
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
