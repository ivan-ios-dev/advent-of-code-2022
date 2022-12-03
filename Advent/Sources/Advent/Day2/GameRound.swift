import Foundation

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
