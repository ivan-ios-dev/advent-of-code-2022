import XCTest
import Foundation
@testable import Advent

enum HandShape {
  case rock
  case paper
  case scissors
  
  func beats() -> Self {
    switch self {
    case .rock: return .scissors
    case .paper: return .rock
    case .scissors: return .paper
    }
  }
  
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
    //Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock
    
    switch (myShape, rivalShape) {
    case (.rock, .rock), (.scissors, .scissors), (.paper, .paper):
      return .draw
    case (.paper, .rock), (.rock, .scissors), (.scissors, .paper):
      return .won
    case (.scissors, .rock), (.paper, .scissors), (.rock, .paper):
      return .lost
    }
  }
  
  //outcome of the round (0 if you lost, 3 if the round was a draw, and 6 if you won)
  enum Outcome: Int {
    case draw = 3
    case lost = 0
    case won = 6
    //X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win.
    init?(myLetter: Character) {
      switch myLetter {
      case "X":
        self = .lost
      case "Y":
        self = .draw
      case "Z":
        self = .won
      default:
        return nil
      }
    }
  }
  
  init(myLetter: Character, rivalLetter: Character) {
    guard let myMove = Outcome(myLetter: myLetter), let rivalShape = HandShape(playerLetter: rivalLetter) else {
      fatalError("Unexpected Input!")
    }
    
    self.rivalShape = rivalShape
    switch myMove {
    case .draw:
      self.myShape = rivalShape
    case .won:
      self.myShape = rivalShape.beats().beats()
    case .lost:
      self.myShape = rivalShape.beats()
    }
  }
  
  var myScore: Int {
    return outcome.rawValue + myShape.score
  }
}

struct Game {
  let rounds: [GameRound]
  var score: Int {
    rounds.map{ $0.myScore }.reduce(0, +)
  }
  
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
  
  func test_gameInitializedFromInput_givesYou_Nscore() throws {
    let sut = try XCTUnwrap(Game.init(data: TestBundle.inputData(for: 2)))
    XCTAssertEqual(sut.score, 12382)

  }
  
  func test_gameRound_withBothRocks_returnsDraw() {
    let sut = GameRound(myLetter: "X", rivalLetter: "A")
    XCTAssertEqual(sut.outcome, .lost)
  }
  
  func test_gameRound_withRock_andMyPaper_returnsWon() {
    let sut = GameRound(myLetter: "Y", rivalLetter: "A")
    XCTAssertEqual(sut.outcome, .draw)
  }
}
