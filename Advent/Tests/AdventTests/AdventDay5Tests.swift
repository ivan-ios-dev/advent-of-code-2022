import Foundation
import XCTest

final class CargoCrane9001: CargoCrane {
  override func perform(command: CargoCrane.MoveCommand) {
    if let sourceStack = cargoField.first(where: { $0.index == command.fromStackIndex } ),
        let destinationStack = cargoField.first(where: { $0.index == command.toStackIndex }) {
      
      var cratesCache: [Character] = []
      
      for _ in 1...command.amount {
        if let crate = sourceStack.takeCrate() {
          cratesCache.append(crate)
        }
      }
      
      for crate in cratesCache.reversed() {
        destinationStack.add(crate: crate)
      }
    }
  }
}

class CargoCrane {
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
  let commands: [MoveCommand]
  
  init(cargoField: [CrateStack], commands: [MoveCommand] = []) {
    self.cargoField = cargoField
    self.commands = commands
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
  
  func performAllCommands() {
    for command in commands {
      perform(command: command)
    }
  }
  
  func topCratesString() -> String {
    let topCrates = cargoField.sorted(by: { $0.index < $1.index }).compactMap{ $0.topCrate }
    return String(topCrates)
  }
}

extension CargoCrane {
  convenience init?(withInput: String) {
    let rows = withInput.components(separatedBy: "\n")
    
    var crates: [CrateStack] = []
    var commands: [MoveCommand] = []
    
    for row in rows {
      //Crates
      if row.contains("[") {
        let chars = Array(row)

        for i in 0..<chars.count {
          let char = chars[i]
          if char == "[" {
            let crate = chars[i+1]
            let index = i/4 + 1
            
            if let existing = crates.first(where: { $0.index == index }) {
              existing.crates.insert(crate, at: 0)
            } else {
              let new = CrateStack(index: index)
              new.add(crate: crate)
              crates.append(new)
            }
          }
        }
      } else if row.contains("move") { // Command
        if let command = MoveCommand(command: row) {
          commands.append(command)
        }
      } else { //Crate Index or last empty line
        print("Row: \(row)")
      }
    }
    
    self.init(cargoField: crates, commands: commands)
  }
}

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

final class AdventDay5Tests: XCTestCase {
  func test_cargoCrane9001_processesMoveCommandList_fromInput() throws {
    let input = TestBundle.inputData(for: 5)
    let inputString = try XCTUnwrap(String(data: input, encoding: .utf8)) // !.components(separatedBy: "\n").filter{ !$0.isEmpty }
    
    let crane = try XCTUnwrap(CargoCrane9001(withInput: inputString))
    
    crane.performAllCommands()
    
    XCTAssertEqual(crane.topCratesString(),"PRTTGRFPB")
  }
  
  func test_cargoCrane9001_movesSeveralCratesAtOnce() {
    let sut = CargoCrane9001(cargoField: [
      .init(crates: ["A", "B"], index: 1),
      .init(crates: ["C", "D", "E"], index: 2)
    ], commands: [
      .init(command: "move 3 from 2 to 1")!
    ])
    
    sut.performAllCommands()
    
    XCTAssertEqual(sut.cargoField[0].crates, ["A", "B", "C", "D", "E"])
  }
  
  func test_cargoCrane_returnsTopCratesList() {
    let s1 = CargoCrane(cargoField: [
      .init(crates: ["A", "B"], index: 1),
      .init(crates: ["C", "D", "E"], index: 2)
    ])
    XCTAssertEqual(s1.topCratesString(), "BE")

    let s2 = CargoCrane(cargoField: [
      .init(crates: ["A", "B"], index: 2),
      .init(crates: ["C", "D", "E"], index: 1)
    ])
    XCTAssertEqual(s2.topCratesString(), "EB")
  }
  
  func test_cargoCrane_processesMoveCommandList_fromInput() throws {
    let input = TestBundle.inputData(for: 5)
    let inputString = try XCTUnwrap(String(data: input, encoding: .utf8)) // !.components(separatedBy: "\n").filter{ !$0.isEmpty }
    
    let crane = try XCTUnwrap(CargoCrane(withInput: inputString))
    
    crane.performAllCommands()
    
    XCTAssertEqual(crane.topCratesString(),"ZRLJGSCTR")
  }
  
  func test_cargoField_andCommandsList_canBeInitialized_fromInput() throws {
    let input = TestBundle.inputData(for: 5)
    let inputString = try XCTUnwrap(String(data: input, encoding: .utf8)) // !.components(separatedBy: "\n").filter{ !$0.isEmpty }
    
    let crane = try XCTUnwrap(CargoCrane(withInput: inputString))
    
    XCTAssertEqual(crane.cargoField.count, 9)
    XCTAssertEqual(
      crane.cargoField.first(where: { $0.index == 1 }),
      CrateStack(crates: ["S", "T", "H", "F", "W", "R"], index: 1)
    )
    
    XCTAssertEqual(crane.commands.count, 502)
  }
  
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
    
    let crane = try XCTUnwrap(CargoCrane(withInput: inputString))
    
    XCTAssertEqual(crane.cargoField.count, 9)
    XCTAssertEqual(
      crane.cargoField.first(where: { $0.index == 1 }),
      CrateStack(crates: ["S", "T", "H", "F", "W", "R"], index: 1)
    )
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
