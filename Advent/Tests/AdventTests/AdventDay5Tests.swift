import Foundation
import XCTest
@testable import Advent

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
