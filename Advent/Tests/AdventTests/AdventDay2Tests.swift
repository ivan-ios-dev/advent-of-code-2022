import XCTest
import Foundation
@testable import Advent

enum HandShape {
  case rock
  case paper
  case scissors
  
  //A for Rock, B for Paper, and C for Scissors
  init?(playerLetter: Character) {
    switch playerLetter {
    case "A":
      self = .rock
    case "B":
      self = .paper
    case "C":
      self = .scissors
    default:
      return nil
    }
  }
  //X for Rock, Y for Paper, and Z for Scissors
  init?(myLetter: Character) {
    switch myLetter {
    case "X":
      self = .rock
    case "Y":
      self = .paper
    case "Z":
      self = .scissors
    default:
      return nil
    }
  }
  //(1 for Rock, 2 for Paper, and 3 for Scissors)
  var score: Int {
    switch self {
    case .rock: return 1
    case .paper: return 2
    case .scissors: return 3
    }
  }
}

struct GameRound {
  let myShape: HandShape
  let rivalShape: HandShape
  var outcome: Outcome {
    return .draw
  }
  
  //outcome of the round (0 if you lost, 3 if the round was a draw, and 6 if you won)
  enum Outcome: Int {
    case draw = 3
    case lost = 0
    case won = 6
  }
  
  init(myLetter: Character, rivalLetter: Character) {
    guard let myShape = HandShape(myLetter: myLetter), let rivalShape = HandShape(playerLetter: rivalLetter) else {
      fatalError("Unexpected Input!")
    }
    
    self.myShape = myShape
    self.rivalShape = rivalShape
  }
  
  var myScore: Int {
    return outcome.rawValue + myShape.score
  }
}

struct Game {
  let rounds: [GameRound]
  
  init(data: Data) {
    let str = String(decoding: data, as: UTF8.self)
    
    let rows = str.components(separatedBy: "\n").filter{ !$0.isEmpty }
    
    var rounds: [GameRound] = []
    
    for row in rows {
      let rivalLetter = row.first!
      let myLetter = row.last!
      
      let round = GameRound(myLetter: myLetter, rivalLetter: rivalLetter)
      rounds.append(round)
    }
    
    self.rounds = rounds
  }
}

final class AdventDay2Tests: XCTestCase {
  func test_gameInitializedFromInput_has2500_rounds() throws {
    let sut = try XCTUnwrap(Game.init(data: TestBundle.inputData(for: 2)))
    XCTAssertEqual(sut.rounds.count, 2500)
  }
  
  
}
